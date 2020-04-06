// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tile _$TileFromJson(Map<String, dynamic> json) {
  return Tile(
    json['x'] as int,
    json['y'] as int,
    ownership: json['ownership'] as int,
    troops: json['troops'] as int,
    power: json['power'] as int,
    defense: json['defense'] as int,
    moneyGeneration: json['moneyGeneration'] as int,
    troopGeneration: json['troopGeneration'] as int,
  )..activesList = (json['activesList'] as List)
      ?.map(
          (e) => e == null ? null : Active.fromJson(e as Map<String, dynamic>))
      ?.toList();
}

Map<String, dynamic> _$TileToJson(Tile instance) => <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
      'ownership': instance.ownership,
      'troops': instance.troops,
      'power': instance.power,
      'defense': instance.defense,
      'activesList': instance.activesList?.map((e) => e?.toJson())?.toList(),
      'moneyGeneration': instance.moneyGeneration,
      'troopGeneration': instance.troopGeneration,
    };
