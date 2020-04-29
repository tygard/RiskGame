// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    username: json['username'] as String,
    color: json['color'] as String,
    googleID: json['googleID'] as String,
    id: json['id'] as String,
    email: json['email'] as String,
  )..inGamePlayerNumber = json['inGamePlayerNumber'] as int;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'username': instance.username,
      'color': instance.color,
      'email': instance.email,
      'googleID': instance.googleID,
      'id': instance.id,
      'inGamePlayerNumber': instance.inGamePlayerNumber,
    };
