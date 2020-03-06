import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FloatingActionButton(
          heroTag: "chat btn",
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          backgroundColor: Colors.blueGrey,
          child: Icon(
            Icons.chat,
            color: Colors.white,
            size: 35,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: FloatingActionButton(
            heroTag: "end turn btn",
            onPressed: () {
              print("turn ended");
            },
            backgroundColor: Colors.red,
            child: Text("End Turn", textAlign: TextAlign.center, style: TextStyle(color: Colors.white),)
          ),
        ),
      ],
    );
  }
}