import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:growthdeck/constants/constants.dart';
import 'package:growthdeck/constants/mille_sanders_icons.dart';
import 'package:growthdeck/services/http_service.dart';
import 'package:growthdeck/services/local_storage_service.dart';

class Decks extends ChangeNotifier {
  String error;
  LocalStorageService _localStorageService;
  HttpService _httpService;

  List<CardSection> cardSections;
  CardDeck selectedDeck;
  bool isDoneLoading = false;

  void setSelectedDeck(CardDeck cardDeck) {
    selectedDeck = cardDeck;
    notifyListeners();
  }

  Future<void> loadData(
    LocalStorageService localStorageService,
    HttpService httpService,
  ) async {
    if (localStorageService == null ||
        httpService == null ||
        (_httpService != null && _localStorageService == null)) {
      return;
    }
    _localStorageService = localStorageService;
    _httpService = httpService;

    double localVersion = await _localStorageService.getVersion();
    double newestVersion;
    try {
      newestVersion = (await _httpService.getJson(kVersionUrl))["version"];
    } catch (e) {
      dynamic data = await _localStorageService.getFile(kFileName);
      cardSections =
          List.generate(data.length, (i) => CardSection.fromJson(data[i]));
      isDoneLoading = true;
      notifyListeners();
      return;
    }
    try {
      if (localVersion != null && localVersion == newestVersion) {
        dynamic data = await _localStorageService.getFile(kFileName);
        cardSections =
            List.generate(data.length, (i) => CardSection.fromJson(data[i]));
      } else {
        await reloadData();
        return;
      }
    } catch (e) {
      await reloadData();
    }
    isDoneLoading = true;
    notifyListeners();
  }

  Future<void> reloadData() async {
    error = null;
    isDoneLoading = false;
    notifyListeners();
    try {
      double newestVersion =
          (await _httpService.getJson(kVersionUrl))["version"];
      dynamic data = await _httpService.getJson(kDataUrl);
      cardSections =
          List.generate(data.length, (i) => CardSection.fromJson(data[i]));
      _localStorageService.writeFile(kFileName, data);
      _localStorageService.setVersion(newestVersion);
    } catch (e) {
      print(e);
      error =
          "Make sure you are connected to the internet. If the error persists, contact the us at email.";
    }
    isDoneLoading = true;
    notifyListeners();
  }

  static Color colorFromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static IconData getIcon(String icon) {
    switch (icon) {
      case "quotes":
        return MilleSanders.noun_quotes;
      case "tips":
        return MilleSanders.noun_tips;
      case "exit":
        return MilleSanders.noun_exit;
      case "peak":
        return MilleSanders.noun_peak;
      case "business idea":
        return MilleSanders.noun_business_idea;
      case "book":
        return MilleSanders.noun_write;
      default:
        return MilleSanders.noun_idea;
    }
  }
}

class CardSection {
  String name;
  List<CardDeck> cardDecks;
  CardSection.fromJson(dynamic json) {
    name = json['sectionName'] as String;
    cardDecks = List<CardDeck>();
    json['decks']
        .forEach((dynamic deck) => cardDecks.add(CardDeck.fromJson(deck)));
  }
}

class CardDeck {
  String name;
  List<String> filters;
  IconData icon;
  Color color;
  List<Card> cards;

  CardDeck.fromJson(dynamic json) {
    name = json['deckName'] as String;
    filters = json['filterIcons'].cast<String>() as List<String>;
    icon = Decks.getIcon(json['icon'] as String);
    color = Decks.colorFromHex(json['color'] as String);
    cards = List<Card>();
    json['cards']
        .forEach((dynamic cardDeck) => cards.add(Card.fromJson(cardDeck)));
  }
}

class Card {
  String text;
  Color color;
  List<String> filters;

  Card.fromJson(dynamic json) {
    text = json['text'] as String;
    color = Decks.colorFromHex(json['color']);
    filters = json['filter'].cast<String>() as List<String>;
  }
}
