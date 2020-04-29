library globals;

import 'package:flutter/material.dart';
import 'package:risk/models/gameStateObjects/active.dart';
import 'package:risk/models/gameStateObjects/gameState.dart';
import 'package:risk/models/gameStateObjects/passive.dart';
import 'package:risk/src/utils/providers/socketProvider.dart';
import 'package:risk/src/utils/serviceProviders.dart';
import 'package:risk/src/utils/socketManager.dart';
import 'package:risk/src/utils/toaster.dart';
import 'Tile.dart';
import 'dart:math';

List<Passive> passivesList = new List<Passive>();
List<Active> activesList = new List<Active>();
Offset tOffset;
int pTurn = -1;

var selected1;
var selected2;
Color turn = Colors.red;
bool isTurnOver = false;

void attack(var button1, var button2, BuildContext context) {
  button1.armyNum > button2.armyNum
      ? button2.armyNum -= 5
      : button1.armyNum -= 5;
  button1.isSelected = false;
  button2.isSelected = false;
  if (button1.armyNum <= 0) {
    button1.color = button2.color;
    button1.armyNum = 5;
  }
  if (button2.armyNum <= 0) {
    button2.color = button1.color;
    button2.armyNum = 5;
  }
  //Needs testing
  locator<GameState>()
      .board
      .tiles[button1.widget.x * locator<GameState>().board.dimensions +
          button1.widget.y]
      .power = button1.armyNum;
  locator<GameState>()
      .board
      .tiles[button2.widget.x * locator<GameState>().board.dimensions +
          button2.widget.y]
      .power = button2.armyNum;
  button1.widget.update();
  button2.widget.update();
  selected1 = null;
  selected2 = null;
  turn = moveTurn(turn);
  Toaster.successToast("Turn is: " + ColorToString(turn));
  locator<GameState>().turn = ColorToNum(turn);
  SocketProvider.of(context).socketManager.sendGameState(locator<GameState>());
}

Color moveTurn(Color turn) {
  if (turn == Colors.red) {
    return Colors.blue;
  }
  if (turn == Colors.blue) {
    return Colors.green;
  }
  if (turn == Colors.green) {
    return Colors.yellow;
  }
  if (turn == Colors.yellow) {
    return Colors.red;
  }
}

int ColorToNum(Color turn) {
  if (turn == Colors.red) {
    return 0;
  }
  if (turn == Colors.blue) {
    return 3;
  }
  if (turn == Colors.green) {
    return 2;
  }
  if (turn == Colors.yellow) {
    return 1;
  }
}

String ColorToString(Color turn) {
  if (turn == Colors.red) {
    return "Red";
  }
  if (turn == Colors.blue) {
    return "Blue";
  }
  if (turn == Colors.green) {
    return "Green";
  }
  if (turn == Colors.yellow) {
    return "Yellow";
  }
}

Color NumToColor(int num) {
  if (num == 0) return Colors.red;
  if (num == 1) return Colors.yellow;
  if (num == 2) return Colors.green;
  if (num == 3) return Colors.blue;
}

String tileImage(int owner, int army, int displaySeed){
  Random rnd = new Random(displaySeed);
  if (owner == -2) return ("assets/tileTypes/m"+ (rnd.nextInt(2)+1).toString() +".png");
  if (owner == -3) return ("assets/tileTypes/l"+ (rnd.nextInt(1)+1).toString() +".png");
  if (owner > -2){
    if(army == 0 || army == 1){
      return ("assets/tileTypes/h"+(rnd.nextInt(2)+1).toString() +".png");
    }else if(army == 2){
      return ("assets/tileTypes/h"+(rnd.nextInt(3)+4).toString() +".png");
    }else if(army == 3){
      return ("assets/tileTypes/h"+(rnd.nextInt(1)+8).toString() +".png");
    }else if(army > 3){
      return ("assets/tileTypes/v"+(rnd.nextInt(2)+1).toString() +".png");
    }else{
      return ("assets/tileTypes/default.png");
    }
  }
  return ("assets/tileTypes/default.png");
}
