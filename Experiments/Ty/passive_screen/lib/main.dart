import 'package:flutter/material.dart';

void main() {
  runApp(PassiveScreen());
}

class PassiveScreen extends StatefulWidget {
  @override
  _PassiveScreenState createState() => _PassiveScreenState();
}

enum teamColor {
  red, yellow, blue, green
}
/**
 * a passive is an object that modifies the game state,
 * it has a cost, duration and one or more attributes (helpful only)
 */
class Passive {
  String description = "default description";
  int cost = 0;
  int duration = 0;
  bool isActive = false;
  var teamColor;
}

class _PassiveScreenState extends State<PassiveScreen> {
  var currentPassives = new List<Passive>();
  var p = new Passive();
  Color _backgroundColor = Colors.green;

  /**
   * TODO:
   * purchasePassive needs access to the current users team color/name 
   * to determine who the passive should be assigned to.
   * Also updates the state of the FloatingActionButton colors and return value
   */
  void purchasePassive() {
    setState(() {
      if (p.isActive){
        _backgroundColor = Colors.grey[600];
        return null;
      } 
      else {
      // assign a passive to the user
      p.isActive = true;
      }
    });
  }

  void removePassive(){
    setState(() {
      // unassing a passive to the user
      p.isActive = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          // this container holds the entire widget tree for this screen
          constraints: BoxConstraints(
            maxHeight: 500,
          ),
          alignment: Alignment.bottomLeft,
          padding: EdgeInsets.all(0),
          color: Colors.blueGrey,
          child: ListView(
            // this is the list of passive descriptions
            shrinkWrap: true,
            controller: ScrollController(initialScrollOffset: 0),
            children: <Widget>[
              Container(
                // tihs container is a row containing the passive description string and purchase button
                constraints: BoxConstraints(
                  maxHeight: 30,
                ),
                color: Colors.blue,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(4),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.assessment),
                    Text('\t'),
                    Text(p.description),
                    Spacer(
                      flex: 1,
                    ),
                    FloatingActionButton(
                      onPressed: purchasePassive, // call method to update user attributes
                      shape: RoundedRectangleBorder(),
                      child: Text("Buy"),
                      backgroundColor: _backgroundColor,
                    )
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
