import 'package:flutter/material.dart';
import 'package:risk/src/pages/chatRoom.dart';
import 'package:risk/src/pages/homeScreen/loginScreen.dart';
import 'package:risk/src/pages/loadScreen.dart';
import 'noAnimationMaterialPageRoute.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return NoAnimationMaterialPageRoute(builder: (_) => LoadScreen());
      case "/login":
        return NoAnimationMaterialPageRoute(builder: (_) => LoginScreen());
      case "/chat":
        return NoAnimationMaterialPageRoute(builder: (_) => ChatRoom());
      default:
        throw ErrorDescription("route is unknown.");
    }
  }
}
