
import 'package:growthdeck/services/local_storage_service.dart';
import 'package:get_it/get_it.dart';

import 'models/Cards.dart';

GetIt locator = GetIt.instance;

setUpLocator() {
  locator.registerSingletonAsync(LocalStorageService.create);
  locator.registerSingletonAsync(Cards.create, dependsOn: [LocalStorageService]);
}