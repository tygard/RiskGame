import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'GameBoard.dart';
import 'Users.dart';

class SelectTeam extends StatelessWidget {
  Users user;
  final myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Select Your Team")
        ),

        body: new SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 30),
              new TextField(
                obscureText: true,
                controller: myController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Username',
                ),
              ),
              new ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  new MaterialButton(
                    onPressed:  () { Navigator.push(context,MaterialPageRoute(builder: (context) => GameBoard(title: 'Risk')),);
                    user = Users(Colors.red);},
                    child: new Text("Red", style: TextStyle(fontSize: 30)),
                    color: Colors.red,
                    height: 125,
                    minWidth: 125,
                  ),
                  new MaterialButton(
                    onPressed:  () { Navigator.push(context,MaterialPageRoute(builder: (context) => GameBoard(title: 'Risk')),);
                    user = Users(Colors.blue);},
                    child: new Text("Blue", style: TextStyle(fontSize: 30)),
                    color: Colors.blue,
                    height: 125,
                    minWidth: 125,
                  ),
                  new MaterialButton(
                    onPressed:  () { Navigator.push(context,MaterialPageRoute(builder: (context) => GameBoard(title: 'Risk')),);
                    user = Users(Colors.green);},
                    child: new Text("Green", style: TextStyle(fontSize: 30)),
                    color: Colors.green,
                    height: 125,
                    minWidth: 125,
                  ),
                  new MaterialButton(
                    onPressed:  () { Navigator.push(context,MaterialPageRoute(builder: (context) => GameBoard(title: 'Risk')),);
                    user = Users(Colors.yellow);},
                    child: new Text("Yellow", style: TextStyle(fontSize: 30)),
                    color: Colors.yellow,
                    height: 125,
                    minWidth: 125,
                  ),
                ],
              ),
            ],
          ),
        )
    );
  }
}