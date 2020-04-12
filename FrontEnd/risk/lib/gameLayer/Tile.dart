import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'globalVars.dart';



class Tile extends StatefulWidget{
  Function update;
  int x;
  int y;
  int armyNum;
  bool isSelected = false;
  Color c;
  Tile (Function updateGameboard, Color color, int armyNum, int x, int y)
  {
    update = updateGameboard;
    c = color;
    this.armyNum = armyNum;
    this.x = x;
    this.y = y;
  }


  _Tile createState() =>  _Tile();
}

class _Tile extends State<Tile> {
  int armyNum;
  bool isSelected;
  Color color;
  @override
  void initState() {
    armyNum = widget.armyNum;
    isSelected = false;
    color = widget.c;
    super.initState();
  }

  void graySelect() {
    setState(() {
      if (color == turn || color == Colors.grey && selected1 != null) {
        if (isSelected) {
          if (selected1 != null && selected1 == this) {
            selected1 = null;
            selectedTile = null;
          }
          else if (selected2 != null && selected2 == this) {
            selected2 = null;
          }
          isSelected = false;
        }
        else if (!isSelected) {
          if (selected1 != null) {
            if (selected1.color != color) {
              isSelected = true;
            }
          }
          else {
            isSelected = true;
          }
        }
        if (isSelected == true && selected1 == null) {
          selected1 = this;
          selectedTile = widget;
        }
        else if (selected1 != null && selected1 != this && selected2 == null && selected1.color != color)
        {
          selected2 = this;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft,DeviceOrientation.landscapeRight]);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.all(Radius.zero),
        elevation: 5.0,
        child: new MaterialButton(
          onPressed: graySelect,
          child: new Text(armyNum.toString(), style: TextStyle(fontSize: 30)),
          shape: Border.all(color: isSelected ? Colors.white : Colors.black, width: 5),
          color: color,
          height: 125,
          minWidth: 125,
        ),
      ),
    );
  }
}