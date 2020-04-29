import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:risk/gameLayer/utils.dart';
import 'package:risk/models/freezedClasses/user.dart';
import 'package:risk/models/gameStateObjects/gameState.dart';
import 'package:risk/src/pages/gameScreens/passivesScreen.dart';
import 'package:risk/src/utils/attackService.dart';
import 'package:risk/src/utils/serviceProviders.dart';
import 'package:risk/src/utils/turnManager.dart';
import 'package:risk/models/gameStateObjects/gameState.dart';

class ButtonStack extends StatefulWidget {
  _ButtonStack createState() => _ButtonStack();
}

class _ButtonStack extends State<ButtonStack> {
  void initState() {
    _beginListeningToTurnChange();
    super.initState();
  }

  void _beginListeningToTurnChange() {
    locator<GameState>().gameStateDidChange.addListener(() {
      setState(() {
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: new Container(
                color: mapPlayerNumToColor(getPlayerIndex(locator<GameState>().currPlayer)),
                child: Text(
                  "Current turn is: " +
                      mapPlayerNumToColorName(getPlayerIndex(locator<GameState>().currPlayer)),
                  style: TextStyle(fontSize: 20),
                ))),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: new Container(
                color: mapPlayerNumToColor(locator<User>().inGamePlayerNumber),
                child: Text(
                  "Your color is: " +
                      mapPlayerNumToColorName(
                          locator<User>().inGamePlayerNumber),
                  style: TextStyle(fontSize: 20),
                ))),
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
                MaterialPageRoute(
                  builder: (context) => new PassivesScreen(),
                ),
              );
            },
            child: Icon(Icons.attach_money),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: FloatingActionButton(
              heroTag: "end turn btn",
              onPressed:
                  locator<AttackService>().attackDidHappen.notifyListeners,
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
