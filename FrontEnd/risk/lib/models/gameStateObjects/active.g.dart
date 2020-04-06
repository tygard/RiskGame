// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Active _$ActiveFromJson(Map<String, dynamic> json) {
  return Active(
    cost: json['cost'] as int,
    power: json['power'] as int,
    defense: json['defense'] as int,
    duration: json['duration'] as int,
  )..tile = json['tile'] == null
      ? null
      : Tile.fromJson(json['tile'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ActiveToJson(Active instance) => <String, dynamic>{
      'tile': instance.tile?.toJson(),
      'cost': instance.cost,
      'duration': instance.duration,
      'power': instance.power,
      'defense': instance.defense,
    };
