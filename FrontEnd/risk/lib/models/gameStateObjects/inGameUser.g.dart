// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inGameUser.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InGameUser _$InGameUserFromJson(Map<String, dynamic> json) {
  return InGameUser(
    ownedTiles: (json['ownedTiles'] as List)
        ?.map(
            (e) => e == null ? null : Tile.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    money: json['money'] as int,
    ownedPassives: (json['ownedPassives'] as List)
        ?.map((e) =>
            e == null ? null : Passive.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    troopMultiplier: (json['troopMultiplier'] as num)?.toDouble(),
    moneyMultiplier: (json['moneyMultiplier'] as num)?.toDouble(),
    genTroops: json['genTroops'] as int,
    genMoney: json['genMoney'] as int,
    userName: json['userName'] as String,
    faction: json['faction'] as String,
    turnID: json['turnID'] as int,
    role: json['role'] as String,
  );
}

Map<String, dynamic> _$InGameUserToJson(InGameUser instance) =>
    <String, dynamic>{
      'ownedTiles': instance.ownedTiles?.map((e) => e?.toJson())?.toList(),
      'money': instance.money,
      'ownedPassives':
          instance.ownedPassives?.map((e) => e?.toJson())?.toList(),
      'troopMultiplier': instance.troopMultiplier,
      'moneyMultiplier': instance.moneyMultiplier,
      'genTroops': instance.genTroops,
      'genMoney': instance.genMoney,
      'userName': instance.userName,
      'faction': instance.faction,
      'turnID': instance.turnID,
      'role': instance.role,
    };
