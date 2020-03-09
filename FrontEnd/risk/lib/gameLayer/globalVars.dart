library globals;
import 'package:flutter/material.dart';
import 'package:risk/models/gameStateObjects/gameState.dart';
import 'package:risk/src/utils/serviceProviders.dart';
import 'Users.dart';
var selected;
Color turn = Colors.red;

void attack(var button1, var button2)
{
    button1.armyNum > button2.armyNum ? button2.armyNum-=5 : button1.armyNum-=5;
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
    locator<GameState>().board.tiles[button1.x + button1.y].troops = button1.armyNum;
    locator<GameState>().board.tiles[button2.x + button2.y].troops = button2.armyNum;
    button1.widget.update();
    button2.widget.update();
    selected = null;
}

Color moveTurn(Color turn)
{
    if (turn == Colors.red) {
        return Colors.blue;
    }
    if (turn == Colors.blue){
        return Colors.green;
    }
    if (turn == Colors.green){
        return Colors.yellow;
    }
    if (turn == Colors.yellow){
        return Colors.red;
    }
}

int ColorToNum(Color turn)
{
    if (turn == Colors.red) {
        return 0;
    }
    if (turn == Colors.blue){
        return 3;
    }
    if (turn == Colors.green){
        return 2;
    }
    if (turn == Colors.yellow){
        return 1;
    }
}