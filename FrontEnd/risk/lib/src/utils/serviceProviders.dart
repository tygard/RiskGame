import 'package:get_it/get_it.dart';
import 'package:risk/src/utils/config/debugConfig.dart';

import 'config/config.dart';

GetIt locator = GetIt.I;

void registerServices(){
  locator.registerLazySingleton<Config>(() => new DebugConfig());
}