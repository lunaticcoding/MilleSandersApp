import 'package:flutter_test/flutter_test.dart';
import 'package:growthdeck/constants/constants.dart';
import 'package:growthdeck/models/Decks.dart';
import 'package:growthdeck/services/http_service.dart';
import 'package:growthdeck/services/local_storage_service.dart';
import 'package:mockito/mockito.dart';

import '../mockData.dart';
import '../mocks.dart';

void main() {
  Decks decks;
  LocalStorageService mockLocalStorageService;
  HttpService mockHttpService;

  setUp(() {
    mockLocalStorageService = LocalStorageServiceMock();
    mockHttpService = HttpServiceMock();
    decks = Decks();
  });

  group('Decks load Data correctly', () {
    test('before loadData isDoneLoading is false', () {
      expect(decks.isDoneLoading, false);
    });

    test('while loadData isDoneLoading is false', () {
      when(mockLocalStorageService.getVersion())
          .thenAnswer((_) => Future.delayed(Duration(seconds: 1)));
      decks.loadData(mockLocalStorageService, mockHttpService);
      expect(decks.isDoneLoading, false);
    });

    test('after loadData with error isDoneLoading is true', () async {
      when(mockLocalStorageService.getVersion())
          .thenAnswer((_) => Future.value(null));
      when(mockHttpService.getJson(kVersionUrl))
          .thenAnswer((_) => Future.value({"version": 1.0}));
      when(mockHttpService.getJson(kDataUrl)).thenAnswer((_) {
        throw Exception();
      });
      await decks.loadData(mockLocalStorageService, mockHttpService);
      expect(decks.isDoneLoading, true);
      expect(decks.error, isNotNull);
    });

    test('loadData with same version uses local data', () async {
      when(mockLocalStorageService.getVersion())
          .thenAnswer((_) => Future.value(1.0));
      when(mockHttpService.getJson(kVersionUrl))
          .thenAnswer((_) => Future<double>.value(1.0));
      when(mockLocalStorageService.getFile(kFileName))
          .thenAnswer((_) => Future.value([]));

      await decks.loadData(mockLocalStorageService, mockHttpService);
      verify(mockLocalStorageService.getFile(kFileName)).called(equals(1));
      verifyNever(mockHttpService.getJson(kDataUrl));
      expect(decks.error, isNull);
    });

    test('loadData with higher http version uses http data', () async {
      when(mockLocalStorageService.getVersion())
          .thenAnswer((_) => Future.value(1.0));
      when(mockHttpService.getJson(kVersionUrl))
          .thenAnswer((_) => Future.value({"version": 2.0}));
      when(mockHttpService.getJson(kDataUrl))
          .thenAnswer((_) => Future.value([]));

      await decks.loadData(mockLocalStorageService, mockHttpService);
      verify(mockHttpService.getJson(kDataUrl)).called(1);
      verifyNever(mockLocalStorageService.getFile(kFileName));
      expect(decks.error, isNull);
    });

    test('loadData with no http version uses local data', () async {
      when(mockLocalStorageService.getVersion())
          .thenAnswer((_) => Future.value(1.0));
      when(mockHttpService.getJson(kVersionUrl)).thenAnswer((_) {
        throw Exception();
      });
      when(mockLocalStorageService.getFile(kFileName))
          .thenAnswer((_) => Future.value([]));

      await decks.loadData(mockLocalStorageService, mockHttpService);
      verify(mockLocalStorageService.getFile(kFileName)).called(1);
      verifyNever(mockHttpService.getJson(kDataUrl));
      expect(decks.error, isNull);
    });

    test('loadData with no local data calls http', () async {
      when(mockLocalStorageService.getVersion())
          .thenAnswer((_) => Future.value(null));
      when(mockHttpService.getJson(kVersionUrl))
          .thenAnswer((_) => Future.value({"version": 1.0}));
      when(mockHttpService.getJson(kDataUrl))
          .thenAnswer((_) => Future.value([]));

      await decks.loadData(mockLocalStorageService, mockHttpService);
      verify(mockHttpService.getJson(kDataUrl)).called(1);
      expect(decks.error, isNull);
    });

    test('loadData with data sets cardDecks', () async {
      when(mockLocalStorageService.getVersion())
          .thenAnswer((_) => Future.value(null));
      when(mockHttpService.getJson(kVersionUrl))
          .thenAnswer((_) => Future.value({"version": 1.0}));
      when(mockHttpService.getJson(kDataUrl)).thenAnswer((_) => Future.value([
            {
              "sectionName": "mock",
              "decks": [],
            }
          ]));

      await decks.loadData(mockLocalStorageService, mockHttpService);
      verify(mockHttpService.getJson(kDataUrl)).called(1);
      expect(decks.error, isNull);
      expect(decks.cardSections, isNotEmpty);
    });
  });

  group('test Json constructors', () {
    test('CardSection.fromJson returns correctly for current data model', () {
      CardSection.fromJson(cardSectionJsonMock);
    });

    test('CardDeck.fromJson returns correctly for current data model', () {
      CardDeck.fromJson(cardDeckJsonMock);
    });

    test('Card.fromJson returns correctly for current data model', () {
      Card.fromJson(cardJsonMock);
    });
  });
}