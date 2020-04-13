import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:risk/dataLayer/googleSignIn/googleSignIn.dart';
import 'package:risk/src/pages/homeScreens/homeScreenBoiler.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeScreenBoiler(
          child: Column(
        children: <Widget>[
          _buildButton(
              function: () =>
                  Navigator.of(context).pushReplacementNamed("/queue"),
              text: Text(
                "Play RISK",
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 20),
                textAlign: TextAlign.center,
              ),
              background: Theme.of(context).accentColor),
          _buildButton(
            function: () => signOut(),
            text: Text(
              "Log out",
              style: TextStyle(color: Colors.white, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            background: Colors.red,
          )
        ],
      )),
    );
  }

  Widget _buildButton(
      {Image image, Text text, Color background, Function function}) {
    return Padding(
        padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 500,
          ),
          child: Container(
            width: double.infinity,
            child: Material(
              color: background,
              child: InkWell(
                onTap: function,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: text,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, .25),
                  offset: Offset(0, 2),
                  blurRadius: 4,
                ),
              ],
            ),
          ),
        ));
  }
}
