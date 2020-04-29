import 'dart:math';

import 'package:diagonal_scrollview/diagonal_scrollview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:risk/gameLayer/utils.dart';
import 'package:risk/models/freezedClasses/user.dart';
import 'package:risk/models/gameStateObjects/game.dart';
import 'package:risk/models/gameStateObjects/gameState.dart';
import 'package:risk/src/utils/attackService.dart';
import 'package:risk/src/utils/providers/socketProvider.dart';
import 'package:risk/src/utils/serviceProviders.dart';
import 'package:risk/src/utils/toaster.dart';
import 'Tile.dart';
import 'globalVars.dart';

class GameBoard extends StatefulWidget {
  int maxDimension;

  //TODO convert this to a pure function.
  //this one is the byproduct of a dependant.
  //sloppy, hard to use
  GameBoard() {
    maxDimension =
        locator<GameState>().board.dimensions * TileDisplay.TILE_DIMENSION;
  }

  @override
  _GameBoard createState() => _GameBoard();
}

class _GameBoard extends State<GameBoard> {
  DiagonalScrollViewController _scrollController;
  List<Offset> clickedTiles =
      []; //TODO create a class that is an "attack", that bundles offset1, offset2, power1, power2
  static const MAX_TILES_CLICKED = 2;
  GameState gameState;

  @override
  void initState() {
    gameState = locator<GameState>();
    _beginListeningToAttackChange();
    _beginListeningToGameStateUpdate();
    super.initState();
  }

  Widget build(BuildContext context) {
    return DiagonalScrollView(
      onCreated: (DiagonalScrollViewController controller) {
          _scrollController = controller;},
      maxWidth: widget.maxDimension.toDouble(),
      maxHeight: widget.maxDimension.toDouble(),
      child: Container(
        height: widget.maxDimension.toDouble(),
        width: widget.maxDimension.toDouble(),
        child: _buildMap(),
      ),
    );
  }

  Widget _buildMap() {
    List<List<TileDisplay>> sortedList = [];
    for (int i = 0; i < gameState.board.dimensions; i++) {
      sortedList.add([]);
    }
    //add tiles to list with the sorted x.
    for (final tile in gameState.board.tiles) {
      Offset tile_position = Offset(tile.x.toDouble(), tile.y.toDouble());
      sortedList[tile.x].add(TileDisplay(
        armyNum: tile.troops,
        color: mapPlayerNumToColor(getPlayerIndex(tile.ownership)),
        onClick: _tileClicked,
        position: tile_position,
        owner: tile.ownership,
        isSelected: clickedTiles.contains(tile_position),
        troopGen: tile.troopGeneration,
        tileDisplay: gameState.mapSeed + (tile.y+gameState.board.dimensions)*(tile.x+gameState.board.dimensions),//assign a random int for the display seed
      ));
    }

    //sorts out the x.
    for (List<TileDisplay> listOfTiles in sortedList) {
      listOfTiles.sort((a, b) => a.position.dy.compareTo(b.position.dy));
    }

    //builds the return widget.
    List<Widget> map_list = [];
    for (List<TileDisplay> listOfTiles in sortedList) {
      map_list.add(Column(
        children: listOfTiles,
      ));
    }
    return Row(
      children: map_list,
    );
  }

  void _tileClicked(Offset clickPosition, int ownership) {
    //check if its our turn.
    if (gameState.currPlayer != locator<User>().inGamePlayerNumber) {
      Toaster.warningToast(
          "please wait for your turn. it is currently ${mapPlayerNumToColorName(getPlayerIndex(gameState.currPlayer))}'s turn.");
      return;
    }

    if (ownership < -1) {
      Toaster.warningToast(
          "This is an unselectable tile");
      return;
    }

    //if there are no clicked tiles, check if the tile is ours. if it is, we can leave.
    if (clickedTiles.isEmpty) {
      if (ownership == locator<User>().inGamePlayerNumber) {
        setState(() {
          clickedTiles.add(clickPosition);
        });
        tOffset = clickPosition;
      } else {
        Toaster.warningToast("select a tile you own.");
      }
      return;
    }

    //if there is a reclick, we have to unclick it.
    if (clickedTiles.contains(clickPosition)) {
      setState(() {
        clickedTiles.remove(clickPosition);
      });
      tOffset = null;
      return;
    }

    //if there is only one click, we need to check to makesure we clicked an adjacent tile.
    if (clickedTiles.length == 1) {
      if (adjacentOffset(clickedTiles[0], clickPosition)) {
        setState(() {
          clickedTiles.add(clickPosition);
        });
      } else {
        Toaster.warningToast("select an adjacent tile.");
      }
      return;
    }

    //if we got here, that means we clicked an extra tile.
    Toaster.warningToast("you may only have two selected tiles at a time.");
  }

  //sets the state every time we recieve a gamestate.
  //allows the board to rebuild with new values.
  void _beginListeningToGameStateUpdate() {
    locator<GameState>().gameStateDidChange.addListener(() {
      print("updated gamestate!");
      setState(() {
        this.gameState = locator<GameState>();
      });
      if(gameState.gameOver){
        Toaster.successToast(gameState.users.elementAt(gameState.winner).userName + " won the game, controlling 70% of the board!");
        Navigator.of(context).pushReplacementNamed("/home");
      }

      //TODO: maybe fix this, supposed to scroll to current player tile
      for (Tile t in this.gameState.board.tiles) {
        if (t.ownership == gameState.currPlayer) {
          _scrollController.moveTo(location: Offset(t.x.toDouble() *125, t.y.toDouble()*125));
          break;
        }
      }
      print("${gameState.currPlayer}");
    });
  }

  void _beginListeningToAttackChange() {
    locator<AttackService>().attackDidHappen.addListener(() {
      //pass if we dont have two clciked. if we do, we can attack.
      if (clickedTiles.length != 2) {
        print("[ asasd] ${clickedTiles.length}");
        Toaster.warningToast("Two tiles not clicked. turn passed.");
        return;
      } else {
          _attack();
      }
      //finally, sends gamestate, reset our clicks.
      setState(() {
        clickedTiles = [];
      });
      SocketProvider.of(context)
          .socketManager
          .sendGameState(locator<GameState>());
    });
  }

  void _attack() {
    //get refrences to both tiles in the attack.
    List<Tile> tilesInAttack = [];

    for (final tile in locator<GameState>().board.tiles) {
      for (Offset clickedTile in clickedTiles) {
        if (tile.x == clickedTile.dx && tile.y == clickedTile.dy) {
          tilesInAttack.add(tile);
        }
      }
    }

    //TODO REFACTOR! this is not elegant. can easily be extracted into AttackService.
    //if one is greater than the other, subtract that the troops from both, and whichever is
    //equal to zero turns into a troop 
    if (tilesInAttack[0].troops > tilesInAttack[1].troops){
      tilesInAttack[0].troops -= tilesInAttack[1].troops;
      tilesInAttack[1].troops = 0;
      tilesInAttack[1].ownership = tilesInAttack[0].ownership;
    } else if (tilesInAttack[1].troops > tilesInAttack[0].troops){
      tilesInAttack[0].troops -= tilesInAttack[1].troops;
      tilesInAttack[0].troops = 0;
      tilesInAttack[0].ownership = tilesInAttack[1].ownership;
    } else { //if they're equal, reset both to no ownership and 0 troops.
      tilesInAttack[0].troops = 0;
      tilesInAttack[1].troops = 0;
      tilesInAttack[0].ownership = -1;
      tilesInAttack[1].ownership = -1;
    }
  }
}
