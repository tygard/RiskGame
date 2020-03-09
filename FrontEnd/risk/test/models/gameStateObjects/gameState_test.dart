import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:risk/models/gameStateObjects/gameState.dart';
import 'package:risk/src/utils/serviceProviders.dart';

main() {
  test('Should parse a gamestate fixture into an object', () async {
    registerServices();

    final file = new File('fixtures/game_state.json');
    final json = jsonDecode(await file.readAsString());

    //SHOULD NOT throw an error
    GameState state = GameState.fromJson(json);
    print(state.currPlayer);
  });
}
