import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:risk/src/utils/routeGenerator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight])
      .then((_) {
    runApp(new Risk());
  });
}

class Risk extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Risk',
      theme: ThemeData(
        primaryColor: const Color(0xFF0E1E1E),
        accentColor: const Color(0xFFFFC454),
      ),
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: '/',
    );
  }
}
