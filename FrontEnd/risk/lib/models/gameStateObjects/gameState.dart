import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

import 'gameBoard.dart';
import 'inGameUser.dart';

part 'gameState.g.dart';

@JsonSerializable(explicitToJson: true)
class GameState {
  List<InGameUser> users = [];
  GameBoard board;
  String gameID;

  int mapSeed;
  int turn;
  int currPlayer;

  String type = "gamestate";

 @JsonKey(ignore: true)
  ChangeNotifier gameStateDidChange = new ChangeNotifier();

  final int tileGrowthPercent = 5; //percent out of 100
  final int secondsPerTurn = 60;
  final int initArmyNum = 20;

  final int AITileGrowth = 5; //percent out of 100
  final int initAINum = 10;

  bool gameOver = false;
  int winner;

  GameState.empty();
  GameState(this.users, this.board, this.gameID);

  void fromGameState(GameState state){
    users = state.users;
    board = state.board;
    gameID = state.gameID;
    turn = state.turn;
    currPlayer = state.currPlayer;
    mapSeed = state.mapSeed;
    gameOver = state.gameOver;
    winner = state.winner;
    gameStateDidChange.notifyListeners(); //looool imagine
  }

    factory GameState.fromJson(Map<String, dynamic> json) => _$GameStateFromJson(json);
    Map<String, dynamic> toJson() => _$GameStateToJson(this);
}
