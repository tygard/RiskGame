import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:risk/models/freezedClasses/lobbyState.dart';
import 'package:web_socket_channel/io.dart';

import '../../models/freezedClasses/chat.dart';
import '../../models/gameStateObjects/gameState.dart';
import 'config/config.dart';
import 'serviceProviders.dart';

class SocketManager {
  IOWebSocketChannel channel;
  StreamController<Chat> chatStream = StreamController();
  StreamController<GameState> gameStateStream = StreamController();
  StreamController<LobbyState> lobbyStream = StreamController();

  SocketManager({String channelUrl = "DEFAULT", Map<String, String> headers}) {
    //allows the override of the channel to other channels. just in case.
    if (channelUrl == "DEFAULT") {
      channelUrl = "ws://${locator<Config>().getEndpoint()}/chat";
    }
    debugPrint("connecting to $channelUrl");
    channel = IOWebSocketChannel.connect(channelUrl, headers: headers ?? {});
    _beginDelegation();
  }

  //helper that begins all the other steams.
  void _beginDelegation() {
    _mainDelegator();
    chatDelegator();
    gameStateDelegator();
    lobbyDelegator();
  }

  void dispose() {
    this.channel.sink.close();
    chatStream.close();
    gameStateStream.close();
    lobbyStream.close();
  }

  //this is the main delegator, which reads all the data from the websocket.
  //it delegates out the messages to every other delegator.
  void _mainDelegator() async {
    channel.stream.listen((input) {
      print("message recieved: $input");
      Map<String, dynamic> inputMap = json.decode(input);
      if (inputMap.containsKey("type") && inputMap["type"] == "chat") {
        chatStream.add(Chat.fromJson(inputMap));
      } else if (inputMap.containsKey("type") &&
          inputMap["type"] == "gamestate") {
        gameStateStream.add(GameState.fromJson(inputMap));
      } else if (inputMap.containsKey("type") && inputMap["type"] == "lobby") {
        lobbyStream.add(LobbyState.fromJson(inputMap));
        print(inputMap);
      }
    });
  }

  Stream<Chat> chatDelegator() async* {
    await for (final chat in chatStream.stream) {
      yield chat;
    }
  }

  Stream<GameState> gameStateDelegator() async* {
    await for (final gameState in gameStateStream.stream) {
      yield gameState;
    }
  }

  Stream<LobbyState> lobbyDelegator() async* {
    await for (final lobby in lobbyStream.stream) {
      yield lobby;
    }
  }

  void sendChat(Chat chat) {
    String message = json.encode(
        {"username": chat.name, "message": chat.message, "type": "chat"});
    channel.sink.add(message);
  }

  void sendGameState(GameState state) {
    String message = json.encode({"type": "gamestate", "gamestate": state});
    channel.sink.add(message);
  }
}
