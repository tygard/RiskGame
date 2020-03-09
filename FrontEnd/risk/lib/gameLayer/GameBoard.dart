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
  void initState()
  {
    for (int i = 0; i < locator<GameState>().board.dimensions; i++){
      for (int j = 0; j < locator<GameState>().board.dimensions; j++){
        if (i == 0 && j == 0 || i == 6 && j == 0 || i == 0 && j == 6 ||i == 6 && j == 6) {
          locator<GameState>().board.tiles[i + j].troops = 20;
        }
        else {
          locator<GameState>().board.tiles[i + j].troops = 10;
        }
      }
    }

  }
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
                    Tile t = Tile(updateBoard, Colors.red, locator<GameState>().board.tiles[i+j].troops, i, j);
                    return t;
                  }
                  else if (i == locator<GameState>().board.dimensions - 1 && j == 0) {
                    Tile t = Tile(updateBoard, Colors.blue, locator<GameState>().board.tiles[i+j].troops, i , j);
                    return t;
                  }
                  else if (i == 0 && j == locator<GameState>().board.dimensions - 1) {
                    Tile t = Tile(updateBoard, Colors.green, locator<GameState>().board.tiles[i+j].troops, i , j);
                    return t;
                  }
                  else if (i == locator<GameState>().board.dimensions - 1 && j == locator<GameState>().board.dimensions - 1) {
                    Tile t = Tile(updateBoard, Colors.yellow, locator<GameState>().board.tiles[i+j].troops, i , j);
                    return t;
                  }
                  else {
                    Tile t = Tile(updateBoard, Colors.grey, locator<GameState>().board.tiles[i+j].troops, i, j);
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