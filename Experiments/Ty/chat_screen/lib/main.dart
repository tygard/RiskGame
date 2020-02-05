import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

main(List<String> args) {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  runApp(ChatRoom());
}

class ChatRoom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(
                  text: 'chat',
                ),
                Tab(
                  text: 'user1',
                ),
                Tab(
                  text: 'user2',
                ),
                Tab(
                  text: 'X',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Container(  // chat tab conatins a column widget
                child: Column(  // column widget has children which are the sent messages
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('data1'),
                    Text('data2'),
                  ],
                ),
                
              ),
              Container(),
              Container(),
              Container(), // this is the exit tab so it wont actually have anything in it
            ],
          ),
        ),
      ),
    );
  }
}
