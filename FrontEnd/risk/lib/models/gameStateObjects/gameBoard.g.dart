// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gameBoard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameBoard _$GameBoardFromJson(Map<String, dynamic> json) {
  return GameBoard(
    json['dimensions'] as int,
    (json['tiles'] as List)
        ?.map(
            (e) => e == null ? null : Tile.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GameBoardToJson(GameBoard instance) => <String, dynamic>{
      'dimensions': instance.dimensions,
      'tiles': instance.tiles?.map((e) => e?.toJson())?.toList(),
    };
