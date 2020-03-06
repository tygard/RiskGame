import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:risk/models/gameStateObjects/passive.dart';
import 'package:risk/models/gameStateObjects/gameState.dart';
import 'package:risk/models/gameStateObjects/tile.dart';

import '../../../models/gameStateObjects/game.dart';
import '../../../models/gameStateObjects/game.dart';

class PassivesScreen extends StatefulWidget {
  PassivesScreen();
  final PassiveState pState = new PassiveState();

  @override
  _PassivesScreenState createState() => _PassivesScreenState();
}


/**
 * holds information about the state of the passive objects
 */
class PassiveState {
  static Passive p1 = new Passive();
  static Passive p2 = new Passive();
  List<Passive> passiveArr = [p1, p2];
}

class _PassivesScreenState extends State<PassivesScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PassiveScreen',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.red,
      ),
      home: Scaffold(
        appBar: PreferredSize(
          child: AppBar(
            title: Text("Passive Selection"),
            automaticallyImplyLeading: true,
            leading: BackButton(
              onPressed: () => Navigator.pop(context),
            ),
          ),
          preferredSize: Size.fromHeight(30.0),
        ),
        body: Container(
          // this container holds the entire widget tree for this screen
          constraints: BoxConstraints(
            maxHeight: 500,
          ),
          alignment: Alignment.bottomLeft,
          child: ListView(
            // this is the list of passive descriptions
            shrinkWrap: true,
            controller: ScrollController(initialScrollOffset: 0),
            children: <Widget>[
            ],
          ),
        ),
      ),
    );
  }
}

Widget passiveRow(Passive p){
  return Container(
    // this container is a row containing the passive description string and purchase button
    constraints: BoxConstraints(maxHeight: 60, minHeight: 60),
    color: Colors.blue,
    alignment: Alignment.centerLeft,
    padding: EdgeInsets.all(4),
    child: Row(
      children: <Widget>[
        Icon(Icons.description),
        Text('\t'),
        Text(p.toString()),
        Spacer(
          flex: 1,
        ),
        FlatButton(
          child: Text("Buy"),
          clipBehavior: Clip.antiAlias,
          autofocus: true,
          color: passiveRowColor(p),
          onPressed: () => p.purchase(),
          shape: RoundedRectangleBorder(),
        ),
      ],
    ),
  );
}

Color passiveRowColor(Passive p){
  if (!p.isActive() /* && p.canAfford() */){
    return Colors.green;
  }
  else {
    return Colors.grey;
  }
}