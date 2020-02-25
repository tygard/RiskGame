import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Grid extends StatelessWidget {
  final int dimension;

  Grid({Key key, this.dimension}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _buildColumn(),
    );
  }

  List<Widget> _buildColumn(){
    List<Widget> rows = [];
    for (int i = 0; i < dimension; i++){
      rows.add(_buildRow());
    }
    return rows;
  }

  Widget _buildRow(){
    List<Widget> rowWidgets = [];
    for (int i = 0; i < dimension; i++){
      rowWidgets.add(_buildTile());
    }
    return Row(children: rowWidgets,);
  }

  Widget _buildTile(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(width: 20, height: 20, color: Colors.pink,),
    );
  }
}