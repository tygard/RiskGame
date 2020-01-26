import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';

class LoadScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) { 
        return  Container(
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
        );
      }
}
