// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inGameUser.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InGameUser _$InGameUserFromJson(Map<String, dynamic> json) {
  return InGameUser(
    (json['passives'] as List)
        ?.map((e) =>
            e == null ? null : Passive.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$InGameUserToJson(InGameUser instance) =>
    <String, dynamic>{
      'passives': instance.passives?.map((e) => e?.toJson())?.toList(),
    };
