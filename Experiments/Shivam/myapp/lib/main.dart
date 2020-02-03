import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

void main() => runApp(LogoApp());

class LogoApp extends StatefulWidget {
  _LogoAppState createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin{
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
         super.initState();
         controller =
             AnimationController(duration: const Duration(seconds: 2), vsync: this);
         animation = Tween<double>(begin: 0, end: 300).animate(controller)
           ..addListener(() {
             setState(() {
               // The state that has changed here is the animation object’s value.
             });
           });
         controller.forward();
       }

  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        height: animation.value,
        width: animation.value,
        child: FlutterLogo(),
      ),
        new Container(
          width: 320.0,
          height: 60.0,
          alignment: FractionalOffset.center,
          decoration: new BoxDecoration(
            color: const Color.fromRGBO(247, 64, 106, 1.0),
            borderRadius: new BorderRadius.all(const Radius.circular(30.0)),
          ),
          child: new Text(
            "Sign In", textDirection: TextDirection.ltr,
            style: new TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.w300,
              letterSpacing: 0.3,

            ),
          ),
        )
      ],
    );


  }
  @override
     void dispose() {
         controller.dispose();
         super.dispose();
       }
}