import 'package:flutter/animation.dart';
import 'package:growthdeck/services/http_service.dart';
import 'package:growthdeck/services/local_storage_service.dart';
import 'package:mockito/mockito.dart';

class LocalStorageServiceMock extends Mock implements LocalStorageService {}
class HttpServiceMock extends Mock implements HttpService {}
class AnimationMock extends Mock implements Animation {}
class AnimationControllerMock extends Mock implements AnimationController {}
