import 'package:risk/models/freezedClasses/user.dart';
import 'package:risk/models/gameStateObjects/gameState.dart';
import 'package:risk/src/utils/serviceProviders.dart';

bool isCurrentTurn() {
  return (locator<GameState>().currPlayer == locator<User>().inGamePlayerNumber);
}
