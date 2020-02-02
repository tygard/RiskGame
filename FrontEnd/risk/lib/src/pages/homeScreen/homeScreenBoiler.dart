import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';

class HomeScreenBoiler extends StatelessWidget {
  Widget child;

  HomeScreenBoiler({
    Key key,
    this.child,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Color(0xFf3d787b),
              Theme.of(context).primaryColor,
            ],
            focalRadius: 1.9,
            radius: 0.8,
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
                this.child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
