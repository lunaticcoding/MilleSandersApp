import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growthdeck/constants/constants.dart';
import 'package:growthdeck/models/Decks.dart';
import 'package:mockito/mockito.dart';

import '../mockData.dart';
import '../mocks.dart';

void main() {
  group('test Json constructors', () {
    test('CardSection.fromData returns correctly for current data model', () {
      CardSection.fromData(cardSectionJsonMock);
    });

    test('CardDeck.fromData returns correctly for current data model', () {
      CardDeck.fromData(cardDeckJsonMock);
    });

    test('Card.fromData returns correctly for current data model', () {
      Card.fromData(cardJsonMock);
    });
  });
}
