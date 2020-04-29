import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:risk/dataLayer/riskHttp.dart';
import 'package:risk/models/freezedClasses/user.dart';
import 'package:risk/src/utils/serviceProviders.dart';
import 'package:risk/src/utils/toaster.dart';

class SelectTeam extends StatelessWidget {
  final myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new SizedBox(height: 60),
                new TextField(
                    obscureText: false,
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
                        onPressed: () => _colorSelected("Red", context),
                        child: new Text("Red", style: TextStyle(fontSize: 30)),
                        color: Colors.red,
                        height: 125,
                        minWidth: 125,
                      ),
                      new MaterialButton(
                        onPressed: () => _colorSelected(myController.text, context),
                        child: new Text("Blue", style: TextStyle(fontSize: 30)),
                        color: Colors.blue,
                        height: 125,
                        minWidth: 125,
                      ),
                      new MaterialButton(
                        onPressed: () => _colorSelected(myController.text, context),
                        child: new Text("Green", style: TextStyle(fontSize: 30)),
                        color: Colors.green,
                        height: 125,
                        minWidth: 125,
                      ),
                      new MaterialButton(
                        onPressed: () => _colorSelected(myController.text, context),
                        
                        child: new Text("Yellow", style: TextStyle(fontSize: 30)),
                        color: Colors.yellow,
                        height: 125,
                        minWidth: 125,
                      ),
                    ],
                ),
              ],
            ),
          ),
                  ),
        ));
  }

  void _colorSelected(String color, BuildContext context) async {
    if (myController.text != null && myController.text != "") {
      int colorID = 0;
      //TODO this should be a sealed union
      switch (color) {
        case "Red":
          colorID = 0;
          break;
        case "Green":
          colorID = 1;
          break;
        case "Blue":
          colorID = 2;
          break;
        case "Yellow":
          colorID = 3;
          break;
        default:
      }
      locator<User>().username = myController.text;
      Map<String, dynamic> package = {
        'Username': myController.text,
        'Faction': colorID,
        'googToken': locator<User>().googleID,
        "fbToken": null
      };
      print(package);
      Response response =
          await RiskHttp.makePostRequest("users", params: package);
      Toaster.successToast(response.data.toString());
      Navigator.of(context).pushReplacementNamed("/home");
    } else {
      Toaster.errorToast(
          "Listen here, smart guy. You have to put a name in the box.");
    }
  }
}
