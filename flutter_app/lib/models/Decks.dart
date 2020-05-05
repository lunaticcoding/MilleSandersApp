import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:growthdeck/constants/constants.dart';
import 'package:growthdeck/constants/mille_sanders_icons.dart';

class Decks extends ChangeNotifier {
  List<CardSection> cardSections;
  CardDeck selectedDeck;
  bool hasData = false;
  String error;

  void setSelectedDeck(CardDeck cardDeck) {
    selectedDeck = cardDeck;
    notifyListeners();
  }

  Decks() {
    _loadData();
  }

  void _loadData() {
    Firestore.instance
        .collection(kCollectionName)
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      List<DocumentSnapshot> sections = snapshot.documents
        ..sort((sectionA, sectionB) =>
            (sectionA["id"] as int).compareTo(sectionB["id"] as int));
      cardSections = sections
          .map<CardSection>((snapshot) => CardSection.fromData(snapshot))
          .toList();
      hasData = true;
      notifyListeners();
    }).catchError((error) {
      this.error = error;
      hasData = true;
      notifyListeners();
    });
  }

  void reloadData() {
    hasData = false;
    notifyListeners();
    _loadData();
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
  CardSection.fromData(dynamic json) {
    name = json['sectionName'] as String;
    cardDecks = List<CardDeck>();
    json['decks']
        .forEach((dynamic deck) => cardDecks.add(CardDeck.fromData(deck)));
  }
}

class CardDeck {
  String name;
  List<String> filters;
  IconData icon;
  Color color;
  List<Card> cards;

  CardDeck.fromData(dynamic json) {
    name = json['deckName'] as String;
    filters = json['filterIcons'].cast<String>() as List<String>;
    icon = Decks.getIcon(json['icon'] as String);
    color = Decks.colorFromHex(json['color'] as String);
    cards = List<Card>();
    json['cards']
        .forEach((dynamic cardDeck) => cards.add(Card.fromData(cardDeck)));
  }
}

class Card {
  String text;
  Color color;
  List<String> filters;

  Card.fromData(dynamic json) {
    text = json['text'] as String;
    color = Decks.colorFromHex(json['color']);
    filters = json['filter'].cast<String>() as List<String>;
  }
}
