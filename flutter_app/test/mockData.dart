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

CardDeck filledCardDeckMock = CardDeck.fromJson({
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
