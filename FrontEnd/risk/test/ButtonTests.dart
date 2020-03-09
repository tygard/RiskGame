import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:risk/gameLayer/Tile.dart';
import 'package:flutter/material.dart';
import 'package:risk/gameLayer/globalVars.dart';
// ignore: must_be_immutable
class MockTile extends Mock implements _Tile {
  @override
  // ignore: missing_return
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    super.toString();
  }
}
@override
class _Tile extends State<Tile> {
  int armyNum;
  bool isSelected;
  Color color;
  _Tile(int n, bool s, Color c){
    armyNum = n;
    isSelected = s;
    color = c;
  }
  @override
  void initState() {
    armyNum = widget.armyNum;
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
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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

void main() {
  const Function update = null;

  testWidgets('Territory renders correctly', (WidgetTester tester) async {
    Tile tile1 = new Tile(update, Colors.red, 20, 1, 1);
    Tile tile2 = new Tile(update, Colors.red, 10, 1, 2);
    expect(tile1.armyNum, 20);
    expect(tile2.armyNum, 10);
  });

  testWidgets('Attack works', (WidgetTester tester) async {
    MockTile tile = MockTile();
    when(tile.graySelect()).thenReturn(tile.isSelected = true);
    tile.graySelect();
    expect(tile.isSelected, false);
  });


}