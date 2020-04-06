library globals;

import 'package:flutter/material.dart';
import 'package:risk/models/gameStateObjects/gameState.dart';
import 'package:risk/src/utils/serviceProviders.dart';

var selected1;
var selected2;
Color turn = Colors.red;
bool isTurnOver = false;

void setupLocator() {}

void attack(var button1, var button2) {
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
  button1.widget.update();
  button2.widget.update();
  selected1 = null;
  selected2 = null;
  turn = moveTurn(turn);
  locator<GameState>().turn = ColorToNum(turn);
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

Color NumToColor(int num) {
  if (num == 0) return Colors.red;
  if (num == 1) return Colors.yellow;
  if (num == 2) return Colors.green;
  if (num == 3) return Colors.blue;

}
