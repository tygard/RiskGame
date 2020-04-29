// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gameState.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameState _$GameStateFromJson(Map<String, dynamic> json) {
  return GameState(
    (json['users'] as List)
        ?.map((e) =>
            e == null ? null : InGameUser.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['board'] == null
        ? null
        : GameBoard.fromJson(json['board'] as Map<String, dynamic>),
    json['gameID'] as String,
  )
    ..mapSeed = json['mapSeed'] as int
    ..turn = json['turn'] as int
    ..currPlayer = json['currPlayer'] as int
    ..type = json['type'] as String
    ..gameOver = json['gameOver'] as bool
    ..winner = json['winner'] as int;
}

Map<String, dynamic> _$GameStateToJson(GameState instance) => <String, dynamic>{
      'users': instance.users?.map((e) => e?.toJson())?.toList(),
      'board': instance.board?.toJson(),
      'gameID': instance.gameID,
      'mapSeed': instance.mapSeed,
      'turn': instance.turn,
      'currPlayer': instance.currPlayer,
      'type': instance.type,
      'gameOver': instance.gameOver,
      'winner': instance.winner,
    };
