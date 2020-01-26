import 'package:flutter/material.dart';
import 'package:risk/src/pages/homeScreen/loginScreen.dart';
import 'package:risk/src/pages/loadScreen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => LoadScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      default:
        throw ErrorDescription("route is unknown.");
    }
  }
}
