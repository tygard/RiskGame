import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:risk/gameLayer/GameBoard.dart';
import 'package:risk/gameLayer/Territory.dart';
import 'package:flutter/material.dart';


void main() {
  @Mock
  const Function update;

  testWidgets('Territory renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(new Territory(update, Colors.red, 20));

  });
}