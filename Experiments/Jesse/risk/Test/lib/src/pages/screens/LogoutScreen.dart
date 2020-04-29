import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:risk/services/Account.dart';


class LogoutScreen extends StatelessWidget {
  @override
  UserAccount _user = new UserAccount();
  LogoutScreen(UserAccount user){
    _user = user;
  }
  Widget build(BuildContext context) {
          return new Scaffold(
            body: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    Color(0xFf142829),
                    Theme.of(context).primaryColor,
                  ],
                ),
              ),
              child: SizedBox.expand(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 24.0, bottom: 100.0, left: 50, right: 50),
                  child: Column(

                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GradientText(
                        "RISK",
                        gradient: LinearGradient(
                            colors: [Color(0xFFFFC152), Color(0xFFe57a00)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 56, fontFamily: 'Digital'),
                      ),
                      GradientText(
                        _user.getEmail(),
                        gradient: LinearGradient(
                            colors: [Color(0xFFFFC152), Color(0xFFe57a00)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 56, fontFamily: 'Digital'),
                      ),
                      Column(
                        children: <Widget>[
                          _buildLoginButton(
                            context: context,
                              loginType: 2,
                              image: Image.asset("assets/logos/google.png"),
                              text: Text(
                                "Logout of Google",
                                style: TextStyle(color: Colors.black87, fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                              background: Colors.white),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }

  Widget _buildLoginButton({Image image, Text text, Color background, int loginType, BuildContext context}) {
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
                await _user.signedIn ? Navigator.of(context).pushReplacementNamed("/home") : Navigator.of(context).pushReplacementNamed("/");

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
