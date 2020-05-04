import 'package:growthdeck/models/Decks.dart';

const dynamic cardSectionJsonMock = {
  "sectionName": "mock",
  "decks": [],
};

const dynamic cardDeckJsonMock = {
  "deckName": "mock",
  "filterIcons": [],
  "icon": "mock",
  "color": "#ffffffff",
  "cards": [],
};

const dynamic cardJsonMock = {
  "text": "mock",
  "color": "#ffffffff",
  "filter": [],
};

CardDeck filledCardDeckMock = CardDeck.fromData({
  "deckName": "mock",
  "filterIcons": ["filter1", "filter2"],
  "icon": "mock",
  "color": "#ffffffff",
  "cards": [
    {
      "text": "1",
      "color": "#ffffffff",
      "filter": [],
    },
    {
      "text": "2",
      "color": "#ffffffff",
      "filter": ["filter1"],
    },
    {
      "text": "3",
      "color": "#ffffffff",
      "filter": ["filter2"],
    },
    {
      "text": "4",
      "color": "#ffffffff",
      "filter": ["filter1", "filter2"],
    }
  ],
});

List<CardSection> sectionsMockWithDecks = [
  {
    "sectionName": "section1",
    "decks": [
      {
        "deckName": "deck1",
        "filterIcons": [],
        "icon": "mock",
        "color": "#ffffffff",
        "cards": [],
      },
      {
        "deckName": "deck2",
        "filterIcons": [],
        "icon": "mock",
        "color": "#ffffffff",
        "cards": [],
      }
    ],
  },
  {
    "sectionName": "section2",
    "decks": [
      {
        "deckName": "deck1",
        "filterIcons": [],
        "icon": "mock",
        "color": "#ffffffff",
        "cards": [],
      },
      {
        "deckName": "deck2",
        "filterIcons": [],
        "icon": "mock",
        "color": "#ffffffff",
        "cards": [],
      }
    ],
  }
].map<CardSection>((section) => CardSection.fromData(section)).toList();
