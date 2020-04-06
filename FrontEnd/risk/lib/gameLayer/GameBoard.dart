import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:risk/gameLayer/Tile.dart';
import 'package:risk/gameLayer/globalVars.dart';
import 'package:risk/models/gameStateObjects/gameState.dart';
import 'package:risk/src/utils/serviceProviders.dart';
import 'package:risk/models/gameStateObjects/gameBoard.dart' as gb;
import 'package:risk/models/gameStateObjects/tile.dart' as t;
import 'Tile.dart';

class GameBoard extends StatefulWidget {
  GameBoard({Key key, this.title}) : super(key: key);
  final String title;
  static int dimensions = new Random().nextInt(9) + 7;

  @override
  _GameBoard createState() => _GameBoard();
}

class _GameBoard extends State<GameBoard> {
  List<t.Tile> tiles;

  void createBoard() {
    gb.GameBoard board = locator<GameState>().board;
    if (board == null) {
      int dim = GameBoard.dimensions;
      debugPrint(dim.toString());
      List<t.Tile> tiles = new List();
      int count = 0;
      for (int i = 0; i < dim; i++) {
        for (int j = 0; j < dim; j++) {
          t.Tile tile = new t.Tile(i, j);
          tile.power = 10;
          if (i == 0 && j == 0)
          {
            tile.ownership = 0;
            tile.power = 20;
            tiles.add(tile);
          }
          else if (i == dim - 1 && j == 0)
          {
            tile.ownership = 3;
            tile.power = 20;
            debugPrint(count.toString());
            tiles.add(tile);
          }
          else if (i == 0 && j == dim - 1)
          {
            tile.ownership = 2;
            tile.power = 20;
            debugPrint(count.toString());
            tiles.add(tile);
          }
          else if (i == dim - 1 && j == dim - 1)
          {
            tile.ownership = 1;
            debugPrint(count.toString());
            tiles.add(tile);
          }
          count++;
        }
      }
      locator<GameState>().board = gb.GameBoard(dim, tiles);
    }
  }

  void updateBoard() {
    setState(() {});
  }

  @override
  void initState() {
    createBoard();
    tiles = locator<GameState>().board.tiles;
  }

  //Add array object
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: new SizedBox(
          width: GameBoard.dimensions * 130.0,
          child: new ListView.builder(
            cacheExtent: locator<GameState>().board.dimensions * 130.0,
            //Important to update so flutter doesn't try to constantly reload the buttons. 7 - 16 is the items in a row, 125 is the height
            itemCount: locator<GameState>().board.dimensions,
            //Creates variable rows
            itemBuilder: (BuildContext context, int i) {
              return new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: new List.generate(locator<GameState>().board.dimensions, (int j) {
                  //debugPrint(i.toString() + " " + j.toString());
                  if (tiles[i * locator<GameState>().board.dimensions + j].ownership != -1)
                  {
                    return Tile(updateBoard, NumToColor(tiles[i+j].ownership), 20, i, j);
                  }
                  else
                    return Tile(updateBoard, Colors.grey, 10, i, j);
                }),
              );
            },
          ),
        ),
      ),
    );
  }
}
