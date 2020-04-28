import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:risk/src/pages/screens/homeScreenBoiler.dart';
import 'package:risk/src/pages/screens/LogoutScreen.dart';
import 'package:risk/services/Account.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight])
      .then((_) {
    runApp(new Risk());
  });
}

class Risk extends StatelessWidget {
  @override
  UserAccount user = new UserAccount();
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Risk',
      theme: ThemeData(
        primaryColor: const Color(0xFF0E1E1E),
        accentColor: const Color(0xFFFFC454),
      ),
        initialRoute: '/',
        routes: <String, WidgetBuilder>{
        '/': (_) => new HomeScreenBoiler(user),
        '/home': (_) => new LogoutScreen(user),
      }

    );
  }
}
