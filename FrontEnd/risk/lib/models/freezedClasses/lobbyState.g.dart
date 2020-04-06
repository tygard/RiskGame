// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lobbyState.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LobbyState _$LobbyStateFromJson(Map<String, dynamic> json) {
  return LobbyState(
    playersInLobby: json['playersInLobby'] as int,
    yourPlayerNum: json['yourPlayerNum'] as int,
  );
}

Map<String, dynamic> _$LobbyStateToJson(LobbyState instance) =>
    <String, dynamic>{
      'playersInLobby': instance.playersInLobby,
      'yourPlayerNum': instance.yourPlayerNum,
    };
