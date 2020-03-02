import 'package:get_it/get_it.dart';
import 'package:risk/gameLayer/game.dart';
import 'package:risk/models/freezedClasses/user.dart';
import 'package:risk/src/utils/config/debugConfig.dart';
import 'package:risk/src/utils/config/productionConfig.dart';
import 'package:risk/src/utils/routeGenerator.dart';

import 'config/config.dart';

GetIt locator = GetIt.I;

void registerServices(){
  locator.registerLazySingleton<Config>(() => new ProductionConfig());
  locator.registerLazySingleton<RouteGenerator>(() => new RouteGenerator());
  locator.registerLazySingleton<GameState>(() => new GameState());
  locator.registerLazySingleton<User>(() => new User());
}