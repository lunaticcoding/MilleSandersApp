import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growthdeck/constants/constants.dart';
import 'package:growthdeck/core/error/failures.dart';
import 'package:growthdeck/features/card_deck/data/datasources/section_datasource.dart';
import 'package:growthdeck/features/card_deck/data/models/section_model.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/section_map_fixture.dart';

class FirestoreMock extends Mock implements Firestore {}

class CollectionReferenceMock extends Mock implements CollectionReference {}

class QuerySnapshotMock extends Mock implements QuerySnapshot {
  final List<DocumentSnapshotMock> documents = [
    DocumentSnapshotMock()
  ];
}

class DocumentSnapshotMock extends Mock implements DocumentSnapshot {
  final Map<String, dynamic> data = sectionFixture;
}

main() {
  FirestoreMock firestoreMock;
  CollectionReferenceMock collectionReferenceMock;
  QuerySnapshotMock querySnapshotMock;

  setUp(() {
    firestoreMock = FirestoreMock();
    collectionReferenceMock = CollectionReferenceMock();
    querySnapshotMock = QuerySnapshotMock();
  });

  test('valid data from firestore returns stream of Sections', () async {
    when(firestoreMock.collection(any))
        .thenAnswer((_) => collectionReferenceMock);
    when(collectionReferenceMock.snapshots())
        .thenAnswer((_) => Stream.value(querySnapshotMock));

    final SectionDataSource dataSource = SectionDataSourceImpl(firestoreMock);

    expectLater(dataSource.sections, emits([SectionModel.fromMap(sectionFixture)]));
    verify(firestoreMock.collection(kCollectionName));
  });

  test('error from firestore returns stream emitting NoDataFailure', () async {
    when(firestoreMock.collection(any))
        .thenAnswer((_) => collectionReferenceMock);
    when(collectionReferenceMock.snapshots())
        .thenAnswer((_) => Stream.error(NoDataFailure()));

    final SectionDataSource dataSource = SectionDataSourceImpl(firestoreMock);

    expectLater(dataSource.sections, emitsError(NoDataFailure()));
    verify(firestoreMock.collection(kCollectionName));
  });
}
