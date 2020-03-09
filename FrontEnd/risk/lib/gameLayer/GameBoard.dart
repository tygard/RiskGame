import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:risk/models/gameStateObjects/gameState.dart';
import 'package:risk/src/utils/serviceProviders.dart';
import 'Tile.dart';


class GameBoard extends StatefulWidget
{
  GameBoard({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _GameBoard createState() => _GameBoard();
}

class _GameBoard extends State<GameBoard> {
  void updateBoard({GameBoard game})
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
            cacheExtent: locator<GameState>().board.dimensions*125.0, //Important to update so flutter doesn't try to constantly reload the buttons. 7 is the items in a row, 125 is the height
            itemCount: locator<GameState>().board.dimensions, 
            itemBuilder: (BuildContext context, int i) {
              return new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:
                new List.generate(locator<GameState>().board.dimensions, (int j) {
                  if (i == 0 && j == 0) {
                    Tile t = Tile(updateBoard, Colors.red, 20, i, j);
                    locator<GameState>().board.tiles[i+j].troops = 20;
                    return t;
                  }
                  else if (i == 6 && j == 0) {
                    Tile t = Tile(updateBoard, Colors.blue, 20, i , j);
                    locator<GameState>().board.tiles[i+j].troops = 20;
                    return t;
                  }
                  else if (i == 0 && j == 6) {
                    Tile t = Tile(updateBoard, Colors.green, 20, i , j);
                    locator<GameState>().board.tiles[i+j].troops = 20;
                    return t;
                  }
                  else if (i == 6 && j == 6) {
                    Tile t = Tile(updateBoard, Colors.yellow, 20, i , j);
                    locator<GameState>().board.tiles[i+j].troops = 20;
                    return t;
                  }
                  else {
                    Tile t = Tile(updateBoard, Colors.grey, 10, i, j);
                    locator<GameState>().board.tiles[i+j].troops = 10;
                    return t;
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