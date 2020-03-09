import 'package:json_annotation/json_annotation.dart';

import 'gameBoard.dart';
import 'inGameUser.dart';

part 'gameState.g.dart';

@JsonSerializable(explicitToJson: true)
class GameState {
  List<InGameUser> users = [];
  GameBoard board;
  String gameID;

  int turn;
  int currPlayer;

  GameState.empty();
  GameState(this.users, this.board, this.gameID);

  final int tileGrowthPercent = 5; //percent out of 100
  final int secondsPerTurn = 60;
  final int initArmyNum = 20;

  final int AITileGrowth = 5; //percent out of 100
  final int initAINum = 5;

    factory GameState.fromJson(Map<String, dynamic> json) => _$GameStateFromJson(json);
    Map<String, dynamic> toJson() => _$GameStateToJson(this);
}
