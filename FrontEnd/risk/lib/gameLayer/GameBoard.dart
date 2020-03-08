import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Territory.dart';
import 'globalVars.dart';

class GameBoard extends StatefulWidget
{
  GameBoard({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _GameBoard createState() => _GameBoard();
}

class _GameBoard extends State<GameBoard> {
  void updateBoard()
  {
    setState(() {
    });
  }
  //Add array object
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: new SizedBox(
          width: 1000.0,
          child:
          new ListView.builder(
            cacheExtent: 7*125.0, //Important to update so flutter doesn't try to constantly reload the buttons. 7 is the items in a row, 125 is the height
            itemCount: 7, //Creates 7 rows
            itemBuilder: (BuildContext context, int i) {
              return new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:
                new List.generate(7, (int j) {
                  if (i == 0 && j == 0) {
                    return Territory(updateBoard, Colors.red, 20);
                  }
                  else if (i == 6 && j == 0) {
                    return Territory(updateBoard, Colors.blue, 20);
                  }
                  else if (i == 0 && j == 6) {
                    return Territory(updateBoard, Colors.yellow, 20);
                  }
                  else if (i == 6 && j == 6) {
                    return Territory(updateBoard, Colors.green, 20);
                  }
                  else {
                    return Territory(updateBoard, Colors.grey, 10);
                  }
                }),
              );
            },
          ),
        ),
      ),
    );
  }
}