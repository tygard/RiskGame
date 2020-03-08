import 'dart:convert';

import 'package:web_socket_channel/io.dart';

import '../../models/freezedClasses/chat.dart';
import '../../models/gameStateObjects/gameState.dart';
import 'config/config.dart';
import 'serviceProviders.dart';

class SocketManager {
  IOWebSocketChannel channel;

  SocketManager({String channelUrl = "DEFAULT"}) {
    //allows the override of the channel to other channels. just in case.
    if (channelUrl == "DEFAULT"){
      channelUrl = "ws://${locator<Config>().getEndpoint()}/chat";
    } 
     channel = IOWebSocketChannel.connect(channelUrl);
    _beginDelegation();
  }

  //helper that begins all the other steams.
  void _beginDelegation() {
    _mainDelegator();
    chatDelegator();
    gameStateDelegator();
  }

  //this is the main delegator, which reads all the data from the websocket.
  //it delegates out the messages to every other delegator.
  Stream<dynamic> _mainDelegator() async* {
    await for (var input in channel.stream){
      Map<String, dynamic> inputMap = json.decode(input);
      print(inputMap["type"]);
      if (inputMap.containsKey("type") && inputMap["type"] == "chat"){
        yield Chat.fromJson(inputMap);
      } else if (inputMap.containsKey("type") && inputMap["type"] == "gamestate"){
        yield GameState.fromJson(inputMap);
      }
    }
  }

  Stream<Chat> chatDelegator() async* {
    await for (var chat in _mainDelegator()){
      if (chat is Chat){
        yield chat;
      }
    }
  }

  Stream<GameState> gameStateDelegator() async* {
    await for (var state in _mainDelegator()){
      if (state is GameState){
        yield state;
      }
    }
  }

  void sendChat(Chat chat){
    String message = json.encode({"username": chat.name, "message": chat.message, "type": "chat"});
      channel.sink.add(message);
  }

    void sendGameState(GameState state){
    String message = json.encode({"type": "gamestate", "gamestate": state});
      channel.sink.add(message);
  }
}
