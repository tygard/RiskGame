import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'globalVars.dart';

class TileDisplay extends StatefulWidget {
  int armyNum;
  bool isSelected;
  Color color;
  Offset position;
  int owner;
  void Function(Offset, int) onClick;

  static const TILE_DIMENSION = 30 + 125 + 10; //(padding * 2) + heightwidth + (border * 2) + some tweaking for some reason.

  TileDisplay(
      {this.armyNum, this.isSelected = false, this.color, this.position, this.onClick, this.owner});

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
      padding: EdgeInsets.all(15.0),
      child: Material(
        borderRadius: BorderRadius.all(Radius.zero),
        elevation: 5.0,
        child: new MaterialButton(
          onPressed: () {
            widget.onClick(widget.position, widget.owner);
          },
          child: new Text(widget.armyNum.toString(),
              style: TextStyle(fontSize: 30)),
          shape: Border.all(color: widget.isSelected ? Colors.white : Colors.black, width: 5),
          color: widget.color,
          height: 125,
          minWidth: 125,
        ),
      ),
    );
  }
}
