import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:risk/dataLayer/googleSignIn/googleSignIn.dart';
import 'package:risk/src/pages/homeScreens/homeScreenBoiler.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeScreenBoiler(
        child: Column(
                  children: <Widget>[
                    /*_buildLoginButton(
                        image: Image.asset("assets/logos/facebookLogo.png"),
                        function: (){Navigator.of(context).pushReplacementNamed("/game");},
                        text: Text(
                          "Login with Facebook",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                        background: Color(0xFF3B5998)),*/
                    _buildLoginButton(
                        image: Image.asset("assets/logos/google.png"),
                        function: doLogin,
                        text: Text(
                          "Login with Google",
                          style: TextStyle(color: Colors.black87, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                        background: Colors.white),
                  ],
                )
      ),
    );
  }

  Widget _buildLoginButton({Image image, Text text, Color background, Function function}) {
    const ICON_SIZE = 50.0;

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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: ICON_SIZE,
                        width: ICON_SIZE,
                        child: image,
                      ),
                    ),
                    Expanded(
                      child: text,
                    ),
                    Container(
                      width: ICON_SIZE + 16,
                    ), //
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