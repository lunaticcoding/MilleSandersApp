import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/animation.dart';
import 'package:growthdeck/services/http_service.dart';
import 'package:mockito/mockito.dart';

class FirestoreMock extends Mock implements Firestore {}
class HttpServiceMock extends Mock implements HttpService {}
class AnimationMock extends Mock implements Animation {}
class AnimationControllerMock extends Mock implements AnimationController {}
