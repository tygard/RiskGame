import 'package:flutter/foundation.dart';

import 'gameBoard.dart';
import 'inGameUser.dart';

class GameState {
  List<InGameUser> users = [];
  GameBoard board;
  String gameID;

  int turn = 0;
  int currPlayer = 0;

  final int tileGrowthPercent = 5; //percent out of 100
  final int secondsPerTurn = 60;
  final int initArmyNum = 20;

  final int AITileGrowth = 5; //percent out of 100
  final int initAINum = 5;

  GameState({@required this.users, @required this.board, @required this.gameID});
}
