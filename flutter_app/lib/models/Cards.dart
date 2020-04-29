import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:growthdeck/constants/constants.dart';
import 'package:growthdeck/constants/mille_sanders_icons.dart';
import 'package:growthdeck/services/http_service.dart';
import 'package:growthdeck/services/local_storage_service.dart';

class Cards extends ChangeNotifier {
  String error;
  LocalStorageService _localStorageService;
  List<CardSection> cardSections;
  CardDeck selectedDeck;
  bool isLoading = true;

  void setSelectedDeck(CardDeck cardDeck) {
    selectedDeck = cardDeck;
    notifyListeners();
  }

  Future<void> loadData(LocalStorageService localStorageService) async {
    if (_localStorageService != null || localStorageService == null) {
      return;
    }
    _localStorageService = localStorageService;
    double localVersion = await _localStorageService.getVersion();
    double newestVersion;
    try {
      try {
        newestVersion = (await HttpService.getJson(kVersionUrl))["version"];
      } catch (e) {
        dynamic data = await _localStorageService.getFile(kFileName);
        cardSections =
            List.generate(data.length, (i) => CardSection.fromJson(data[i]));
        isLoading = false;
        notifyListeners();
        return;
      }

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
    isLoading = false;
    notifyListeners();
  }

  Future<void> reloadData() async {
    error = null;
    isLoading = true;
    notifyListeners();
    try {
      double newestVersion =
          (await HttpService.getJson(kVersionUrl))["version"];
      dynamic data = await HttpService.getJson(kDataUrl);
      cardSections =
          List.generate(data.length, (i) => CardSection.fromJson(data[i]));
      _localStorageService.writeFile(kFileName, data);
      _localStorageService.setVersion(newestVersion);
    } catch (e) {
      error =
          "Make sure you are connected to the internet. If the error persists, contact the us at email.";
    }
    isLoading = false;
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

/*
class CardDisplayViewmodel extends ChangeNotifier {
  dynamic _unfilteredCards;
  List<dynamic> _cards;

  bool isReady = false;
  Map<String, bool> filters;

  String deckName;
  int _index = 0;

  CardDisplayViewmodel(cardDeck) {
    _unfilteredCards = cardDeck;
    deckName = _unfilteredCards["deckName"];

    filters = Map.fromIterable(_unfilteredCards["filterIcons"],
        key: (v) => v.toString(), value: (v) => false);
    _cards = _unfilteredCards["cards"].map((elem) => elem).toList();
    isReady = true;
    notifyListeners();
  }

  int getNrValidCards() => _cards.length - _index;

  bool addCard() {
    if (_index > 0) {
      _index--;
      notifyListeners();
      return true;
    }
    return false;
  }

  bool removeCard() {
    if (_index < _cards.length) {
      _index++;
      notifyListeners();
      return true;
    }
    return false;
  }

  List<Widget> forEachCard(Function function) {
    List<dynamic> list = List<Widget>();
    for (int i = _index; i < _cards.length; i++) {
      list.insert(0, function(i == _index, _cards[i]));
    }
    return list;
  }

  void updateFilter() {
    _index = 0;
    _cards = _unfilteredCards["cards"];

    bool applyFilters = filters.values.reduce((val, elem) => val || elem);
    if (applyFilters) {
      _cards = _cards.where(
        (card) {
          for (var entry in filters.entries) {
            if (entry.value) {
              for (var filter in card["filter"]) {
                if (filter == entry.key) {
                  return true;
                }
              }
            }
          }
          return false;
        },
      ).toList();
    }
    notifyListeners();
  }
}
 */

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
    icon = Cards.getIcon(json['icon'] as String);
    color = Cards.colorFromHex(json['color'] as String);
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
    color = Cards.colorFromHex(json['color']);
    filters = json['filter'].cast<String>() as List<String>;
  }
}
