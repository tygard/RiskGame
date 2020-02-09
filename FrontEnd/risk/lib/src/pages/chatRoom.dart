import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 2,
              child: Row(
                children: <Widget>[
                  _buildTab(Colors.pink),
                  _buildTab(Colors.blue),
                  _buildTab(Colors.orange),
                ],
              ),
            ),
            Flexible(
              flex: 9,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFa9a9a9),
                  border: Border.all(color: Colors.brown[600], width: 5),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  Widget _buildTab(Color color){
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Container(
        color: color,
        width: 90,
      ),
    );
  }
}
