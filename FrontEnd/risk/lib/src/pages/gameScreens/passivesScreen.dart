import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:risk/gameLayer/game.dart';

class PassivesScreen extends StatefulWidget {
  PassivesScreen({this.game});
  final GameState game;
  final PassiveState pState = new PassiveState();

  @override
  _PassivesScreenState createState() => _PassivesScreenState();
}

/**
 * a passive is an object that a user can purchase
 * it has a cost, duration, active status and one or more attributes (helpful only)
 */
class Passive {
  String description = "passive name:\n passive attributes";
  int cost = 0;
  int duration = 0;
  bool isActive = false;
  Color buttonColor = Colors.green;

  void setButtonColor() {
    if (isActive) {
      buttonColor = Colors.grey[600];
    } else {
      buttonColor = Colors.green;
    }
  }

  void assign() {
    this.isActive = true;
  }

  void unassign() {
    this.isActive = false;
  }

  void setActive() {
    isActive = true;
  }

  bool getStatus() {
    return this.isActive;
  }

  int getCost() {
    return this.cost;
  }

  int getDuration() {
    return this.duration;
  }

  void simTurn() {
    if (this.duration > 0) {
      this.duration--;
    }
    if (this.duration == 0) {
      unassign();
    }
  }
}

/**
 * holds information about the state of the passive objects
 */
class PassiveState {
  static Passive p1 = new Passive();
  static Passive p2 = new Passive();
  static Passive p3 = new Passive();
  static Passive p4 = new Passive();
  static Passive p5 = new Passive();
  static Passive p6 = new Passive();
  List<Passive> passiveArr = [p1, p2, p3, p4, p5, p6];
}

class _PassivesScreenState extends State<PassivesScreen> {
  /**
   * TODO:
   * purchasePassive needs access to the current users team color/name 
   * to determine who the passive should be assigned to.
   * Also updates the state of the FloatingActionButton colors and return value
   */
  void purchasePassive(Passive p, GameState game) {
    setState(() {
      // assign the given Passive p to the user
      p.assign();
      p.setButtonColor();
    });
  }

  void removePassive(Passive p) {
    setState(() {
      // unassing a passive to the user
      p.unassign();
      p.setButtonColor();
    });
  }

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
          // padding: EdgeInsets.all(0),
          // color: Colors.blueGrey,
          child: ListView(
            // this is the list of passive descriptions
            shrinkWrap: true,
            controller: ScrollController(initialScrollOffset: 0),
            children: <Widget>[
              Container(
                // tihs container is a row containing the passive description string and purchase button
                constraints: BoxConstraints(maxHeight: 60, minHeight: 60),
                color: Colors.blue,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(4),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.assessment),
                    Text('\t'),
                    Text(widget.pState.passiveArr[0].description),
                    Spacer(
                      flex: 1,
                    ),
                    FlatButton(
                      child: Text("Buy"),
                      clipBehavior: Clip.antiAlias,
                      autofocus: true,
                      color: widget.pState.passiveArr[0].buttonColor,
                      onPressed: () => purchasePassive(
                          widget.pState.passiveArr[0], widget.game),
                      shape: RoundedRectangleBorder(),
                    ),
                  ],
                ),
              ),
              Container(
                // tihs container is a row containing the passive description string and purchase button
                constraints: BoxConstraints(maxHeight: 60, minHeight: 60),
                color: Colors.blue,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(4),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.assessment),
                    Text('\t'),
                    Text(widget.pState.passiveArr[1].description),
                    Spacer(
                      flex: 1,
                    ),
                    FlatButton(
                      child: Text("Buy"),
                      clipBehavior: Clip.antiAlias,
                      autofocus: true,
                      color: widget.pState.passiveArr[1].buttonColor,
                      onPressed: () => purchasePassive(
                          widget.pState.passiveArr[1], widget.game),
                      shape: RoundedRectangleBorder(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
