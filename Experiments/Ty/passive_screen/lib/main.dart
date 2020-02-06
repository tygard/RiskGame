import 'package:flutter/material.dart';

void main() {
  runApp(PassivesScreen());
}

class PassivesScreen extends StatelessWidget {
  var p1_desc = 'passive 1 text';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.amber,
        body: Container(
          constraints: BoxConstraints(
            maxHeight: 500,
          ),
          alignment: Alignment.bottomLeft,
          padding: EdgeInsets.all(0),
          color: Colors.green,
          child: ListView(
            shrinkWrap: true,
            controller: ScrollController(initialScrollOffset: 0),
            children: <Widget>[
              // use a loop to build appropriate num of passives with own 'passive' objects
              Container(
                constraints: BoxConstraints(
                  maxHeight: 30,
                ),
                color: Colors.indigoAccent,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(4),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.contact_phone),
                    Text('\t'),
                    Text(p1_desc),
                  ],
                ),
              ),
              Container(
                constraints: BoxConstraints(
                  maxHeight: 30,
                ),
                color: Colors.cyan,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(4),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.contact_phone),
                    Text('\t'),
                    Text(p1_desc),
                  ],
                ),
              ),
              Container(
                constraints: BoxConstraints(
                  maxHeight: 30,
                ),
                color: Colors.cyan,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(4),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.contact_phone),
                    Text('\t'),
                    Text(p1_desc),
                  ],
                ),
              ),
              Container(
                constraints: BoxConstraints(
                  maxHeight: 30,
                ),
                color: Colors.cyan,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(4),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.contact_phone),
                    Text('\t'),
                    Text(p1_desc),
                  ],
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
