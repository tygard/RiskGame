import 'package:json_annotation/json_annotation.dart';

part 'lobbyState.g.dart';

@JsonSerializable()
class LobbyState {
  int playersInLobby;
  int yourPlayerNum;

  LobbyState({this.playersInLobby, this.yourPlayerNum});

  factory LobbyState.fromJson(Map<String, dynamic> json) => _$LobbyStateFromJson(json);
  Map<String, dynamic> toJson() => _$LobbyStateToJson(this);
}