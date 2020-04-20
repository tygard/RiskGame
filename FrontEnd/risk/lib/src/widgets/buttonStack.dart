import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:risk/models/gameStateObjects/gameState.dart';
import 'package:risk/src/pages/gameScreens/passivesScreen.dart';
import 'package:risk/gameLayer/globalVars.dart';
import 'package:risk/src/utils/attackService.dart';
import 'package:risk/src/utils/providers/socketProvider.dart';
import 'package:risk/src/utils/serviceProviders.dart';
import 'package:risk/src/utils/toaster.dart';
import 'package:risk/src/utils/turnManager.dart';

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
        /*
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => new PassivesScreen(),
                ),
              );
            },
            child: Icon(Icons.attach_money),
          ),
        ),
        */
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: FloatingActionButton(
              heroTag: "end turn btn",
              onPressed: locator<AttackService>().attackDidHappen.notifyListeners,
              backgroundColor: endButtonColor(),
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

Color endButtonColor() {
  if (isCurrentTurn()) {
    return Colors.red;
  } else {
    return Colors.grey;
  }
}
