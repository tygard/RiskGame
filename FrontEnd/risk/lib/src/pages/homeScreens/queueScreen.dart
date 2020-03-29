import 'package:flutter/material.dart';
import 'package:risk/models/freezedClasses/lobbyState.dart';
import 'package:risk/models/freezedClasses/user.dart';
import 'package:risk/models/gameStateObjects/gameState.dart';
import 'package:risk/src/utils/config/config.dart';
import 'package:risk/src/utils/serviceProviders.dart';
import 'package:risk/src/utils/socketManager.dart';

class QueueScreen extends StatefulWidget {
  @override
  _QueueScreenState createState() => _QueueScreenState();
}

class _QueueScreenState extends State<QueueScreen> {
  int playerCount = 1;
  int myNum = 0;

  SocketManager sm;

  @override
  void initState() {
    sm = SocketManager(
        channelUrl: "ws://${locator<Config>().getEndpoint()}/lobby");
    locator<User>().inGamePlayerNumber = null;
    _beginListeningToLobby();
    super.initState();
  }

  @override
  void dispose(){
    sm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                heroTag: "game",
                onPressed: () =>
                    Navigator.of(context).pushReplacementNamed("/game"),
                child: Icon(
                  Icons.cake,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                onPressed: () =>
                    Navigator.of(context).pushReplacementNamed("/home"),
                child: Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("You are currently in the queue for a game."),
              Text(
                  "If you're a developer, you can click that cake button to move to the game screen."),
              Text("Otherwise, either wait or click the exit to leave."),
              Text("Players in queue: $playerCount / 4",
                  style: TextStyle(color: Colors.grey))
            ],
          ),
        ),
      ),
    );
  }

  void _beginListeningToLobby() {
    sm.lobbyDelegator().listen((lobby) {
      setState(() {
        myNum = myNum ?? lobby.playersInLobby;
        this.playerCount = lobby.playersInLobby;
      });
    });
    _beginListeningForGamestates();
    _beginListeningForLobby();
  }

  void _beginListeningForGamestates() {
    sm.gameStateDelegator().listen((gameState) {
        if (locator<User>().inGamePlayerNumber == null){
        locator<GameState>().fromGameState(gameState);
      }
    });
  }

    void _beginListeningForLobby() {
    sm.lobbyDelegator().listen((lobbyMessage) {
      //will setPlayernum = the amount of players in lobby ONLY IF
      //we do not yet have a player num
      if (locator<User>().inGamePlayerNumber == null){
        locator<User>().inGamePlayerNumber = lobbyMessage.playersInLobby;
      }
    });
  }
}
