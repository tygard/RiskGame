import 'package:get_it/get_it.dart';
import 'package:risk/gameLayer/game.dart';
import 'package:risk/models/freezedClasses/user.dart';
import 'package:risk/src/utils/config/debugConfig.dart';
import 'package:risk/src/utils/routeGenerator.dart';
import 'package:risk/src/utils/socketManager.dart';

import 'config/config.dart';
import 'config/debugConfig.dart';

GetIt locator = GetIt.I;

void registerServices(){
  locator.registerLazySingleton<Config>(() =>  DebugConfig());
  locator.registerLazySingleton<RouteGenerator>(() =>  RouteGenerator());
  locator.registerLazySingleton<GameState>(() =>  GameState());
  locator.registerLazySingleton<User>(() =>  User());
  locator.registerLazySingleton<SocketManager>(() => SocketManager());
  }
