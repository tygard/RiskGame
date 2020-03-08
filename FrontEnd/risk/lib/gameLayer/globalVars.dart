library globals;
import 'package:flutter/material.dart';
import 'package:game_basis/Users.dart';
var selected;
Users user1;
Users user2;
Users user3;
Users user4;
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