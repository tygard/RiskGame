import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';

class LoadScreen extends StatefulWidget {
  @override
  _LoadScreenState createState() => _LoadScreenState();
}

class _LoadScreenState extends State<LoadScreen> {
  @override
  void initState() {
    super.initState();
    _determineLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Center(
            child: GradientText(
          "RISK",
          gradient: LinearGradient(
              colors: [Color(0xFFFFC152), Color(0xFFe57a00)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 56, fontFamily: 'Digital'),
        )),
      ),
    );
  }

  void _determineLogin() async {
    bool userIsLogged = false;
    //this needs to return true or false; update later
    await Future.delayed(const Duration(seconds: 2))
        .then((userIsLogged) => {_determineFlow(userIsLogged)});
  }

  void _determineFlow(userIsLogged) {
    bool userIsLogged = true;
    if (userIsLogged) {
      Navigator.of(context).pushReplacementNamed('/homeScreen');
    } else {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }
}
