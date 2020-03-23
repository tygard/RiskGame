import 'package:flutter/material.dart';
import 'package:risk/gameLayer/GameBoard.dart';
import 'package:risk/src/pages/gameScreens/selectTeam.dart';
import 'package:risk/src/pages/homeScreens/homeScreen.dart';
import 'package:risk/src/pages/homeScreens/loginScreen.dart';
import 'package:risk/src/pages/homeScreens/queueScreen.dart';
import 'package:risk/src/pages/loadScreen.dart';
import 'package:risk/src/pages/overlay.dart';
import 'noAnimationMaterialPageRoute.dart';

class RouteGenerator {
  final GlobalKey<NavigatorState> key =
      new GlobalKey<NavigatorState>();

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return NoAnimationMaterialPageRoute(builder: (_) => LoadScreen());
      case "/login":
        return NoAnimationMaterialPageRoute(builder: (_) => LoginScreen());
      case "/home":
        return NoAnimationMaterialPageRoute(builder: (_) => HomeScreen());
      case "/queue":
        return NoAnimationMaterialPageRoute(builder: (_) => QueueScreen());
      case "/onboard/selectTeam/": //UNUSED
        return NoAnimationMaterialPageRoute(builder: (_) => SelectTeam());
      case "/game":
        return NoAnimationMaterialPageRoute(builder: (_) => RiskOverlay(child: GameBoard(title: "Filler")));
      default:
        throw ErrorDescription("route is unknown.");
    }
  }

  void generateRouteNamed(String name){
     key.currentState.pushReplacementNamed(name);
  }
}