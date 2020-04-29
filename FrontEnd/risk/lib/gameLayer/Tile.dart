import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'globalVars.dart';

class TileDisplay extends StatefulWidget {
  int armyNum;
  bool isSelected;
  Color color;
  int troopGen;
  int tileDisplay; //used as a random seed so the picture is always the same
  Offset position;
  int owner;
  void Function(Offset, int) onClick;

  static const TILE_DIMENSION = 5+ 125; //(padding * 2) + heightwidth + (border * 2) + some tweaking for some reason.

  TileDisplay(
      {this.armyNum, this.isSelected = false, this.color, this.position, this.onClick, this.owner, this.troopGen, this.tileDisplay});

  _TileDisplay createState() => _TileDisplay();
}

class _TileDisplay extends State<TileDisplay> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(1.0),
      child: Material(
        borderRadius: BorderRadius.all(Radius.zero),
        elevation: 5.0,
        child: new InkWell(
          onTap: () {
            widget.onClick(widget.position, widget.owner);
          },
            child: new Container(
              decoration:new BoxDecoration(
                image:new DecorationImage(
                    image: new AssetImage(tileImage(widget.owner, widget.troopGen, widget.tileDisplay)),
                    fit: BoxFit.fill),
                border: Border.all(color: widget.isSelected ? Colors.white : widget.color, width: 5),
              ),
              child: new Center(
                child: Text(widget.armyNum.toString(), style: TextStyle(fontSize: 30), textAlign: TextAlign.center,),
              ),
              width: 125,
              height: 125,
            ),
          /*child: new Text(widget.armyNum.toString(),
              style: TextStyle(fontSize: 30))
          shape: Border.all(color: widget.isSelected ? Colors.white : widget.color, width: 5),
          color: Color.fromRGBO(255, 255, 255, 0),
          height: 125,
          minWidth: 125,*/
        ),
      ),
    );
  }
}
