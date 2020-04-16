
import 'package:get_it/get_it.dart';

import 'models/Cards.dart';

GetIt locator = GetIt.instance;

setUpLocator() {
  locator.registerLazySingleton(() => Cards());
}