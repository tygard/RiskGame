import 'package:get_it/get_it.dart';
import 'package:risk/models/freezedClasses/user.dart';
import 'package:risk/models/gameStateObjects/gameState.dart';
import 'package:risk/src/utils/attackService.dart';
import 'package:risk/src/utils/config/debugConfig.dart';
import 'package:risk/src/utils/config/productionConfig.dart';
import 'package:risk/src/utils/routeGenerator.dart';
import 'package:risk/src/utils/socketManager.dart';

import 'config/config.dart';
import 'config/productionConfig.dart';

GetIt locator = GetIt.I;


void registerServices({bool production = false}){
  if (production){
    locator.registerLazySingleton<Config>(() =>  ProductionConfig());
  } else {
    locator.registerLazySingleton<Config>(() =>  DebugConfig());
  }
  locator.registerLazySingleton<RouteGenerator>(() =>  RouteGenerator());
  locator.registerLazySingleton<GameState>(() =>  GameState.empty());
  locator.registerLazySingleton<User>(() =>  User());
    locator.registerLazySingleton<AttackService>(() =>  AttackService());
  }