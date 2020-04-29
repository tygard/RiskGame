
import 'package:after_init/after_init.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:risk/models/freezedClasses/chat.dart';
import 'package:risk/src/utils/providers/globalsProvider.dart';
import 'package:risk/src/utils/providers/socketProvider.dart';
import 'package:risk/src/utils/serviceProviders.dart';
import 'package:risk/src/utils/socketManager.dart';
import 'package:risk/src/widgets/buttonStack.dart';
import '../../models/freezedClasses/user.dart';

class RiskOverlay extends StatefulWidget {
  final Widget child;

  RiskOverlay({Key key, @required this.child}) : super(key: key);

  @override
  _RiskOverlayState createState() => _RiskOverlayState();
}

class _RiskOverlayState extends State<RiskOverlay>
    with AfterInitMixin<RiskOverlay> {
  int numChats = 0;
  TextEditingController _textController;
  ScrollController _scrollController;
  List<Chat> chats;
  SocketManager sm;

  @override
  void initState() {
    _textController = TextEditingController();
    _scrollController = ScrollController(initialScrollOffset: 0);
    chats = new List<Chat>();
    super.initState();
  }

  void didInitState() {
    sm = SocketManager(
      headers: {
        "id": locator<User>().inGamePlayerNumber,
      },
    );
    _beginListeningToChat();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: Colors.brown,
        drawer: Container(
          width: MediaQuery.of(context).size.width * 0.40,
          child: Drawer(
            child: _buildChatroom(),
          ),
        ),
        body: SocketProvider(
          socketManager: sm,
                  child: Stack(
            children: <Widget>[
              widget.child,
              SafeArea(
                child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: ButtonStack(),
                    )),
              )
            ],
          ),
        ),
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
            SingleChildScrollView(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    child: TextField(
                  decoration: InputDecoration(hintText: "chat"),
                  controller: _textController,
                  onSubmitted: _sendChat,
                )),
              ),
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
          Text(this.chats[index].whenSent,
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

  void _sendChat(String message) {
    _textController.clear();
    Chat chat = Chat(GlobalsProvider.of(context).user.username, message,
        DateFormat('EEE, h:mm a').format(DateTime.now()));
    sm.sendChat(chat);
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

  void _beginListeningToChat() {
    sm.chatDelegator().listen((chat) {
      if (chat.name == locator<User>().username) {
        debugPrint("{name: ${chat.name}, chat: ${chat.message}");
        debugPrint("your name: ${locator<User>().username}");
        chat.name = "You";
        _addItem(chat);
      } else {
        _addItem(chat);
      }
    });
  }
}
