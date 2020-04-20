import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:risk/main.dart';
import 'package:risk/models/gameStateObjects/game.dart';
import 'package:risk/gameLayer/globalVars.dart';
import 'package:risk/src/pages/gameScreens/passivesScreen.dart';
import 'package:risk/src/utils/serviceProviders.dart';

class MockPassive extends Mock implements Passive {}

class MockActive extends Mock implements Active {}



/*
void main() {
  test('call passive functions', () async {
    Passive mockP = MockPassive();
    PassivesScreen ps = new PassivesScreen();
    ps.createState().purchasePassive(mockP);
    verify(mockP.getCost()).called(1);
  });
}
*/
