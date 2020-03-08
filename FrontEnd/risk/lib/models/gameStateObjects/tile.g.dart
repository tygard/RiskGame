// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tile _$TileFromJson(Map<String, dynamic> json) {
  return Tile(
    json['x'] as int,
    json['y'] as int,
    json['ownership'] as int,
    json['troops'] as int,
    json['power'] as int,
    json['defense'] as int,
    json['moneyGeneration'] as int,
    json['troopGeneration'] as int,
  );
}

Map<String, dynamic> _$TileToJson(Tile instance) => <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
      'ownership': instance.ownership,
      'troops': instance.troops,
      'power': instance.power,
      'defense': instance.defense,
      'moneyGeneration': instance.moneyGeneration,
      'troopGeneration': instance.troopGeneration,
    };
