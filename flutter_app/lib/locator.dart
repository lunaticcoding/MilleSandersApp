
import 'package:growthdeck/services/local_storage_service.dart';
import 'package:get_it/get_it.dart';
import 'package:growthdeck/services/navigation_service.dart';

import 'models/Cards.dart';

GetIt locator = GetIt.instance;

setUpLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerSingletonAsync(LocalStorageService.create);
  locator.registerSingletonAsync(Cards.create, dependsOn: [LocalStorageService]);
}