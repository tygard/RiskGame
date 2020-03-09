import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:risk/src/utils/providers/globalsProvider.dart';
import 'package:risk/src/utils/routeGenerator.dart';
import 'package:risk/src/utils/serviceProviders.dart';

import 'models/freezedClasses/user.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  registerServices();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight])
      .then((_) {
    runApp(new Risk());
  });
}

class Risk extends StatelessWidget {
@override
  Widget build(BuildContext context) {
    return GlobalsProvider(
          user: locator<User>(),
          child: MaterialApp(
        title: 'Risk',
        theme: ThemeData(
          primaryColor: const Color(0xFF0E1E1E),
          accentColor: const Color(0xFFFFC454),
        ),
        onGenerateRoute: locator<RouteGenerator>().generateRoute,
        initialRoute: '/',
        navigatorKey: locator<RouteGenerator>().key,
      ),
    );
  }
}
