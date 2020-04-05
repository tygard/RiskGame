// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    name: json['name'] as String,
    color: json['color'] as String,
    googleID: json['googleID'] as String,
    uuid: json['uuid'] as String,
    email: json['email'] as String,
  )..inGamePlayerNumber = json['inGamePlayerNumber'] as int;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'color': instance.color,
      'email': instance.email,
      'googleID': instance.googleID,
      'uuid': instance.uuid,
      'inGamePlayerNumber': instance.inGamePlayerNumber,
    };
