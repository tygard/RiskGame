import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:risk/src/pages/gameScreens/passivesScreen.dart';

class ButtonStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: new FloatingActionButton(
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
        ),
        Padding(
<<<<<<< HEAD
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: new FloatingActionButton(
=======
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: FloatingActionButton(
>>>>>>> 145d3dfbf8de88bc07548e5ac0d492d79ca4658a
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => PassivesScreen()));
            },
            child: Text(
              "\$",
              textScaleFactor: 2.0,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: FloatingActionButton(
              heroTag: "end turn btn",
              onPressed: () {
                print("turn ended");
              },
              backgroundColor: Colors.red,
              child: Text(
                "End Turn",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              )),
        ),
      ],
    );
  }
}
