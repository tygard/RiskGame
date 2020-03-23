import 'package:flutter/material.dart';

class QueueScreen extends StatefulWidget {
  @override
  _QueueScreenState createState() => _QueueScreenState();
}

class _QueueScreenState extends State<QueueScreen> {
  int playerCount = 1;

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
              Text("Players in queue: $playerCount / 4", style: TextStyle(color: Colors.grey))
            ],
          ),
        ),
      ),
    );
  }
}
