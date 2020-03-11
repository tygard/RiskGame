import 'package:get_it/get_it.dart';
import 'package:risk/models/freezedClasses/user.dart';
import 'package:risk/models/gameStateObjects/gameState.dart';
import 'package:risk/src/utils/config/debugConfig.dart';
import 'package:risk/src/utils/routeGenerator.dart';
import 'package:risk/src/utils/socketManager.dart';

import 'config/config.dart';
import 'config/productionConfig.dart';

GetIt locator = GetIt.I;

void registerServices(){
  locator.registerLazySingleton<Config>(() =>  ProductionConfig());
  locator.registerLazySingleton<RouteGenerator>(() =>  RouteGenerator());
  locator.registerLazySingleton<GameState>(() =>  GameState.empty());
  locator.registerLazySingleton<User>(() =>  User());
  locator.registerLazySingleton<SocketManager>(() => SocketManager());
  }
