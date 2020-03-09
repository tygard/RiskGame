// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'passive.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Passive _$PassiveFromJson(Map<String, dynamic> json) {
  return Passive(
    cost: json['cost'] as int,
    passiveValue: json['passiveValue'] as int,
    modifiedValue:
        _$enumDecodeNullable(_$PassiveModifiersEnumMap, json['modifiedValue']),
  )
    ..owner = json['owner'] as int
    ..active = json['active'] as bool
    ..duration = json['duration'] as int;
}

Map<String, dynamic> _$PassiveToJson(Passive instance) => <String, dynamic>{
      'cost': instance.cost,
      'owner': instance.owner,
      'active': instance.active,
      'passiveValue': instance.passiveValue,
      'duration': instance.duration,
      'modifiedValue': _$PassiveModifiersEnumMap[instance.modifiedValue],
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$PassiveModifiersEnumMap = {
  PassiveModifiers.none: 'none',
  PassiveModifiers.defense: 'defense',
  PassiveModifiers.attack: 'attack',
  PassiveModifiers.troopGeneration: 'troopGeneration',
  PassiveModifiers.moneyGeneration: 'moneyGeneration',
};
