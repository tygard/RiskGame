import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Risk',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.red,
      ),
      home: MyHomePage(title: 'Risk'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class GameState
{
  int redArmy = 20;
  bool isRed = false;
  int blueArmy = 20;
  bool isBlue = false;
  int greenArmy = 20;
  bool isGreen = false;
  int yellowArmy = 20;
  bool isYellow = false;
  int grayArmy = 5;
  bool isGray = false;
}

class NeutralArmy
{
  int grayArmy = 5;
  bool isGray = false;
}

class _MyHomePageState extends State<MyHomePage> {
  var rng = new Random();
  GameState game = new GameState();

  void redSelect() {
    setState(() {
      if (game.isRed){
        game.isRed = false;
      }
      else if (!game.isRed)
      {
        game.isRed = true;
      }
      if (game.isRed && game.isBlue)
      {
        attack(game, "Red", "Blue");
      }
      if (game.isRed && game.isGreen)
      {
        attack(game, "Red", "Green");
      }
      if (game.isRed && game.isYellow)
      {
        attack(game, "Red", "Yellow");
      }
      if (game.isRed && game.isGray)
      {
        attack(game, "Red", "Gray");
      }
    });
  }

  void blueSelect() {
    setState(() {
      if (game.isBlue) {
        game.isBlue = false;
        }
      else if (!game.isBlue)
      {
        game.isBlue = true;
      }
      if (game.isBlue && game.isRed)
      {
        attack(game, "Blue", "Red");
      }
      if (game.isBlue && game.isGreen)
      {
        attack(game, "Blue", "Green");
      }
      if (game.isBlue && game.isYellow)
      {
        attack(game, "Blue", "Yellow");
      }
      if (game.isBlue && game.isGray)
      {
        attack(game, "Blue", "Gray");
      }
    });
  }
  void greenSelect() {
    setState(() {
      if (game.isGreen){
        game.isGreen = false;
      }
      else if (!game.isGreen)
      {
        game.isGreen = true;
      }
      if (game.isGreen && game.isRed)
      {
        attack(game, "Green", "Red");
      }
      if (game.isGreen && game.isBlue)
      {
        attack(game, "Green", "Blue");
      }
      if (game.isGreen && game.isYellow)
      {
        attack(game, "Green", "Yellow");
      }
      if (game.isGreen && game.isGray)
      {
        attack(game, "Green", "Gray");
      }
    });
  }
  void yellowSelect() {
    setState(() {
      if (game.isYellow){
        game.isYellow = false;
      }
      else if (!game.isYellow)
      {
        game.isYellow = true;
      }
      if (game.isYellow && game.isRed)
      {
        attack(game, "Yellow", "Red");
      }
      if (game.isYellow && game.isBlue)
      {
        attack(game, "Yellow", "Blue");
      }
      if (game.isYellow && game.isGreen)
      {
        attack(game, "Yellow", "Green");
      }
      if (game.isYellow && game.isGray)
      {
        attack(game, "Yellow", "Gray");
      }
    });
  }
  void graySelect() {
    setState(() {
      if (game.isGray){
        game.isGray = false;
      }
      else if (!game.isGray)
      {
        game.isGray = true;
      }
      if (game.isGray && game.isRed)
      {
        attack(game, "Gray", "Red");
      }
      if (game.isGray && game.isBlue)
      {
        attack(game, "Gray", "Blue");
      }
      if (game.isGray && game.isGreen)
      {
        attack(game, "Gray", "Green");
      }
      if (game.isGray && game.isYellow)
      {
        attack(game, "Gray", "Yellow");
      }
    });
  }

  void attack(GameState game, String army1, String army2)
  {
    if (army1 == "Red" && army2 == "Blue" || army1 == "Blue" && army2 == "Red") {
        (game.blueArmy > game.redArmy) ? game.redArmy = game.redArmy - 5 : game.blueArmy = game.blueArmy - 5;
        game.isRed = !game.isRed;
        game.isBlue = !game.isBlue;
      }
    if (army1 == "Red" && army2 == "Green" || army1 == "Green" && army2 == "Red") {
      (game.greenArmy > game.redArmy) ? game.redArmy = game.redArmy - 5 : game.greenArmy = game.greenArmy - 5;
      game.isRed = !game.isRed;
      game.isGreen = !game.isGreen;
    }
    if (army1 == "Red" && army2 == "Yellow" || army1 == "Yellow" && army2 == "Red") {
      (game.yellowArmy > game.redArmy) ? game.redArmy = game.redArmy - 5 : game.yellowArmy = game.yellowArmy - 5;
      game.isRed = !game.isRed;
      game.isYellow = !game.isYellow;
    }
    if (army1 == "Green" && army2 == "Blue" || army1 == "Blue" && army2 == "Green") {
      (game.greenArmy > game.blueArmy) ? game.blueArmy = game.blueArmy - 5 : game.greenArmy = game.greenArmy - 5;
      game.isBlue = !game.isBlue;
      game.isGreen = !game.isGreen;
    }
    if (army1 == "Green" && army2 == "Yellow" || army1 == "Yellow" && army2 == "Green") {
      (game.greenArmy > game.yellowArmy) ? game.yellowArmy = game.yellowArmy - 5 : game.greenArmy = game.greenArmy - 5;
      game.isYellow = !game.isYellow;
      game.isGreen = !game.isGreen;
    }
    if (army1 == "Yellow" && army2 == "Blue" || army1 == "Blue" && army2 == "Yellow") {
      (game.yellowArmy > game.blueArmy) ? game.blueArmy = game.blueArmy - 5 : game.yellowArmy = game.yellowArmy - 5;
      game.isYellow = !game.isYellow;
      game.isBlue = !game.isBlue;
    }
    if (army1 == "Gray" && army2 == "Red" || army1 == "Red" && army2 == "Gray") {
      (game.grayArmy > game.redArmy) ? game.redArmy = game.redArmy - 5 : game.grayArmy = game.grayArmy - 5;
      game.isGray = !game.isGray;
      game.isRed = !game.isRed;
    }
    if (army1 == "Gray" && army2 == "Blue" || army1 == "Blue" && army2 == "Gray") {
      (game.grayArmy > game.blueArmy) ? game.blueArmy = game.blueArmy - 5 : game.grayArmy = game.grayArmy - 5;
      game.isGray = !game.isGray;
      game.isBlue = !game.isBlue;
    }
    if (army1 == "Gray" && army2 == "Yellow" || army1 == "Blue" && army2 == "Yellow") {
      (game.grayArmy > game.yellowArmy) ? game.yellowArmy = game.yellowArmy - 5 : game.grayArmy = game.grayArmy - 5;
      game.isGray = !game.isGray;
      game.isYellow = !game.isYellow;
    }
    if (army1 == "Gray" && army2 == "Green" || army1 == "Green" && army2 == "Yellow") {
      (game.grayArmy > game.greenArmy) ? game.greenArmy = game.greenArmy - 5 : game.grayArmy = game.grayArmy - 5;
      game.isGray = !game.isGray;
      game.isGreen = !game.isGreen;
    }
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft,DeviceOrientation.landscapeRight]);
    return Scaffold(
        appBar: PreferredSize(
        preferredSize: Size.fromHeight(30.0),
      child: AppBar(
        title: Text(widget.title),
      ),
        ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  new MaterialButton(
                    onPressed: greenSelect,
                    child: new Text(game.greenArmy.toString(), style: TextStyle(fontSize: 30)),
                    shape: Border.all(color: game.isGreen ? Colors.white : Colors.black, width: 5),
                    color: Colors.green,
                    height: 100,
                    minWidth: 100,

                  ),
                  new MaterialButton(
                    onPressed: graySelect,
                    child: new Text(game.grayArmy.toString(), style: TextStyle(fontSize: 30)),
                    shape: Border.all(color: game.isGray ? Colors.white : Colors.black, width: 5),
                    color: Colors.grey,
                    height: 100,
                    minWidth: 100,

                  ),
                  new MaterialButton(
                    onPressed: graySelect,
                    child: new Text(game.grayArmy.toString(), style: TextStyle(fontSize: 30)),
                    shape: Border.all(color: game.isGray ? Colors.white : Colors.black, width: 5),
                    color: Colors.grey,
                    height: 100,
                    minWidth: 100,

                  ),
                  new MaterialButton(
                    onPressed: redSelect,
                    child: new Text(game.redArmy.toString(), style: TextStyle(fontSize: 30)),
                    color: Colors.red,
                    shape: Border.all(color: game.isRed ? Colors.white : Colors.black, width: 5),
                    height: 100,
                    minWidth: 100,
                  ),
                ],
              ),
            new ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                new MaterialButton(
                  onPressed: graySelect,
                  child: new Text(game.grayArmy.toString(), style: TextStyle(fontSize: 30)),
                  shape: Border.all(color: game.isGray ? Colors.white : Colors.black, width: 5),
                  color: Colors.grey,
                  height: 100,
                  minWidth: 100,

                ),
                new MaterialButton(
                  onPressed: graySelect,
                  child: new Text(game.grayArmy.toString(), style: TextStyle(fontSize: 30)),
                  shape: Border.all(color: game.isGray ? Colors.white : Colors.black, width: 5),
                  color: Colors.grey,
                  height: 100,
                  minWidth: 100,

                ),
                new MaterialButton(
                  onPressed: graySelect,
                  child: new Text(game.grayArmy.toString(), style: TextStyle(fontSize: 30)),
                  shape: Border.all(color: game.isGray ? Colors.white : Colors.black, width: 5),
                  color: Colors.grey,
                  height: 100,
                  minWidth: 100,

                ),
                new MaterialButton(
                  onPressed: graySelect,
                  child: new Text(game.grayArmy.toString(), style: TextStyle(fontSize: 30)),
                  shape: Border.all(color: game.isGray ? Colors.white : Colors.black, width: 5),
                  color: Colors.grey,
                  height: 100,
                  minWidth: 100,

                ),
              ],
            ),
             new ButtonBar(
               alignment: MainAxisAlignment.center,
               children: <Widget>[
                 new MaterialButton(
                   onPressed: blueSelect,
                   child: new Text(game.blueArmy.toString(), style: TextStyle(fontSize: 30)),
                   shape: Border.all(color: game.isBlue ? Colors.white : Colors.black, width: 5),
                   color: Colors.blue,
                   height: 100,
                   minWidth: 100,
                  ),
                 new MaterialButton(
                   onPressed: graySelect,
                   child: new Text(game.grayArmy.toString(), style: TextStyle(fontSize: 30)),
                   shape: Border.all(color: game.isGray ? Colors.white : Colors.black, width: 5),
                   color: Colors.grey,
                   height: 100,
                   minWidth: 100,

                 ),
                 new MaterialButton(
                   onPressed: graySelect,
                   child: new Text(game.grayArmy.toString(), style: TextStyle(fontSize: 30)),
                   shape: Border.all(color: game.isGray ? Colors.white : Colors.black, width: 5),
                   color: Colors.grey,
                   height: 100,
                   minWidth: 100,

                 ),
                  new MaterialButton(
                   onPressed: yellowSelect,
                   child: new Text(game.yellowArmy.toString(), style: TextStyle(fontSize: 30)),
                    shape: Border.all(color: game.isYellow ? Colors.white : Colors.black, width: 5),
                   color: Colors.yellow,
                    height: 100,
                    minWidth: 100,
                  ),
                ],
              ),
            ],
        ),
      ),
    );
  }
}
