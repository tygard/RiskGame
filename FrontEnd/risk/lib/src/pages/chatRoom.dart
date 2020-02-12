import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:risk/models/freezedClasses/chat.dart';
import 'package:web_socket_channel/io.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  int numChats = 0;
  TextEditingController _textController;
  ScrollController _scrollController;
  List<Chat> chats;
  final channel = IOWebSocketChannel.connect('ws://localhost:8080/chat/global');

  @override
  void initState() {
    _beginListeningToGlobal();
    _textController = TextEditingController();
    _scrollController = ScrollController(initialScrollOffset: 0);
    chats = new List<Chat>();
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    this.channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      drawer: Container(
        width: MediaQuery.of(context).size.width * 0.40,
        child: Drawer(
          child: _buildChatroom(),
        ),
      ),
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Builder(
                    builder: (context) => FloatingActionButton(
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      backgroundColor: Colors.blueGrey,
                      child: Icon(
                        Icons.chat,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                  ),
                )),
          )
        ],
      ),
    );
  }

  Widget _buildChatroom() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: this.numChats,
                itemBuilder: (context, index) => _buildChat(index),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  child: TextField(
                decoration: InputDecoration(hintText: "chat"),
                controller: _textController,
                onSubmitted: _selfChat,
              )),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildChat(int index) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0, top: 4.0),
            child: Text(
              this.chats[index].name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            this.chats[index].message,
          ),
          Text(DateFormat('EEE, h:mm a').format(DateTime.now()),
              style: TextStyle(
                color: Colors.grey,
              )),
        ],
      ),
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Colors.grey[300], width: 1))),
    );
  }

  void _selfChat(String message) {
    _textController.clear();
    Map<String, String> jsonMsg  = new Map<String, String>();
    jsonMsg["username"] = "Anthony";
    jsonMsg["message"] = message;
    channel.sink.add(json.encode(jsonMsg));
    _addItem(Chat("You", message));
  }

  void _addItem(Chat chat) async {
    setState(() {
      this.numChats += 1;
      this.chats.add(chat);
    });

    //this is a hacky way to wait for the element to be added and then scroll to after it.
    //if there is any other solution, it is probably better.
    if (this.chats.length > 1) {
      Future.delayed(Duration(milliseconds: 15)).then((_) {
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 250), curve: Curves.linear);
      });
    }
  }

  void _beginListeningToGlobal() {
    this.channel.stream.listen((chat) {
      Map<String, dynamic> map = json.decode(chat);
      if (map["username"] == "Anthony"){
      _addItem(Chat(map["username"], map["message"]));
      }
    });
  }
}