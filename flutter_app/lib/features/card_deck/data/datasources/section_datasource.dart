import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:growthdeck/constants/constants.dart';
import 'package:growthdeck/core/error/failures.dart';
import 'package:growthdeck/features/card_deck/data/models/section_model.dart';

abstract class SectionDataSource {
  Stream<List<SectionModel>> _sections;
  Stream<List<SectionModel>> get sections => _sections;
}

class SectionDataSourceImpl extends SectionDataSource {
  SectionDataSourceImpl(Firestore firestore) {
    _sections = firestore.collection(kCollectionName).snapshots().transform(
          StreamTransformer<QuerySnapshot, List<SectionModel>>.fromHandlers(
            handleData: (QuerySnapshot data, EventSink sink) {
              sink.add(data.documents
                  .map<SectionModel>(
                    (document) => SectionModel.fromMap(document.data),
                  )
                  .toList());
            },
            handleError: (Object error, StackTrace stacktrace, EventSink sink) {
              // TODO Acount for different types of error!
              sink.addError(NoDataFailure());
            },
            handleDone: (EventSink sink) => sink.close(),
          ),
        );
  }
}
