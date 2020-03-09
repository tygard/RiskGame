import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'globalVars.dart';



class Territory extends StatefulWidget{
  Function update;
  int num;
  Color c;
  Territory (Function updateGameboard, Color color, int armyNum)
  {
    update = updateGameboard;
    c = color;
    num = armyNum;
  }

  _Territory createState() =>  _Territory();
}

class _Territory extends State<Territory> {
  int armyNum;
  bool isSelected;
  Color color;
  @override
  void initState() {
    armyNum = widget.num;
    isSelected = false;
    color = widget.c;
    super.initState();
  }

  void graySelect() {
    setState(() {
      if (color == turn || color == Colors.grey && selected != null) {
        if (isSelected) {
          if (selected != null) {
            selected = null;
          }
          isSelected = false;
        }
        else if (!isSelected) {
          if (selected != null) {
            if (selected.color != color) {
              isSelected = true;
            }
          }
          else {
            isSelected = true;
          }
        }
        if (isSelected == true && selected == null) {
          selected = this;
        }
        else
        if (selected != null && selected != this && selected.color != color) {
          attack(this, selected);
          turn = moveTurn(turn);
          print(turn);
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