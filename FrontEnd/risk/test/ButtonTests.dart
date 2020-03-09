import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:risk/gameLayer/Tile.dart';
import 'package:flutter/material.dart';
import 'package:risk/gameLayer/globalVars.dart';



void main() {
  const Function update = null;

  testWidgets('Territory renders correctly', (WidgetTester tester) async {
    Tile t = new Tile(update, Colors.red, 20, 1, 1);
    expect(t.armyNum, 20);
  });

  
}