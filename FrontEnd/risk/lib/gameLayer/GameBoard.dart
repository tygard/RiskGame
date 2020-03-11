import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:risk/gameLayer/Tile.dart';
import 'Tile.dart';
import 'dart:math';

class GameBoard extends StatefulWidget
{
  GameBoard({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _GameBoard createState() => _GameBoard();
}

class _GameBoard extends State<GameBoard> {
  int dimensions = (new Random().nextInt(9) + 7);
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
          width: dimensions * 130.0,
          child:
          new ListView.builder(
            cacheExtent: dimensions*130.0, //Important to update so flutter doesn't try to constantly reload the buttons. 7 is the items in a row, 125 is the height
            itemCount: dimensions, //Creates 7 rows
            itemBuilder: (BuildContext context, int i) {
              return new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:
                new List.generate(dimensions, (int j) {
                  if (i == 0 && j == 0) {
                    return Tile(updateBoard, Colors.red, 20, i, j);
                  }
                  else if (i == dimensions - 1 && j == 0) {
                    return Tile(updateBoard, Colors.blue, 20, i, j);
                  }
                  else if (i == 0 && j == dimensions - 1) {
                    return Tile(updateBoard, Colors.yellow, 20, i, j);
                  }
                  else if (i == dimensions - 1 && j == dimensions - 1) {
                    return Tile(updateBoard, Colors.green, 20, i, j);
                  }
                  else {
                    return Tile(updateBoard, Colors.grey, 10, i, j);
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