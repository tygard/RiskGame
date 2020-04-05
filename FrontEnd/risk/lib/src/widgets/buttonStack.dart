import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:risk/src/pages/gameScreens/passivesScreen.dart';
import 'package:risk/gameLayer/globalVars.dart';
import 'package:risk/src/utils/toaster.dart';

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
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: FloatingActionButton(
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
                if (selected1 == null && selected2 == null)
                {
                  Toaster.errorToast("Please select a valid territory to attack and a territory to attack it");
                }
                else {
                  isTurnOver = true;
                  attack(selected1, selected2);
                  turn = moveTurn(turn);
                }
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
