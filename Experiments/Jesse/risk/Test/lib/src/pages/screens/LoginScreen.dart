import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  @override
  AuthScreenState createState() {
    return new AuthScreenState();
  }
}

class AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return new Container(
      width: width,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _buildLoginButton(
              context: context,
              loginType: 1,
              image: Image.asset("assets/logos/facebookLogo.png"),
              text: Text(
                "Login with Facebook",
                style: TextStyle(color: Colors.white, fontSize: 20),
                textAlign: TextAlign.center,
              ),
              background: Color(0xFF3B5998)),
          _buildLoginButton(
              context: context,
              loginType: 0,
              image: Image.asset("assets/logos/google.png"),
              text: Text(
                "Login with Google",
                style: TextStyle(color: Colors.black87, fontSize: 20),
                textAlign: TextAlign.center,
              ),
              background: Colors.white),
        ],
      ),
    );
  }

  Widget _buildLoginButton(
      {Image image,
        Text text,
        Color background,
        int loginType,
        BuildContext context}) {
    const ICON_SIZE = 50.0;

    return Padding(
        padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
        child: Container(
          width: double.infinity,
          child: Material(
            color: background,
            child: InkWell(
              onTap: () async {
                _user.SignIn(loginType);
                await _user.signedIn
                    ? Navigator.of(context).pushReplacementNamed("/home")
                    : Navigator.of(context).pushReplacementNamed("/");
              },
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
        ));
  }
}


