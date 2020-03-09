import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:risk/models/gameStateObjects/passive.dart';
import 'package:risk/models/gameStateObjects/gameState.dart';
import 'package:risk/models/gameStateObjects/tile.dart';

import '../../../models/gameStateObjects/game.dart';
import '../../../models/gameStateObjects/game.dart';

class PassivesScreen extends StatefulWidget {
  List<Passive> passivesList = List<Passive>();
  /**
   * a passive screen needs a list of passives, usually the InGameUsers owned passives 
   * FOR TESTING: if there is no passive list given it populates passivesList with 5 random passives
   */
  PassivesScreen({this.passivesList}) {
    if (passivesList == null || passivesList.length == 0) {
      this.passivesList = new List<Passive>();
      this.passivesList.add(new Passive());
      this.passivesList.add(new Passive());
      this.passivesList.add(new Passive());
      this.passivesList.add(new Passive());
      this.passivesList.add(new Passive());
    }
  }

  @override
  _PassivesScreenState createState() => _PassivesScreenState();
}

class _PassivesScreenState extends State<PassivesScreen> {
  /**
   * --- I just set the passives active property to true for a quick test that things are working
   * TODO: use a reference to this gameState to call the current users purchase passive
   * function on this passive
   */
  void purchasePassive(Passive p) {
    setState(() {
      p.active = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PassiveScreen',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.red,
      ),
      home: Scaffold(
        appBar: PreferredSize(
          child: AppBar(
            title: Text("Passives Selection"),
            leading: BackButton(
              onPressed: () => Navigator.pop(context),
            ),
          ),
          preferredSize: Size.fromHeight(50.0),
        ),
        body: _createPassivesList(widget.passivesList),
      ),
    );
  }

  Widget _createPassivesList(List<Passive> pList) {
    return Container(
      // this container holds the entire widget tree for this screen
      alignment: Alignment.bottomLeft,
      child: ListView.builder(
        itemCount: pList.length,
        itemBuilder: (context, index) {
          //return _passiveRow(pList[index]);
          return ListTile(
            onTap: () {
              purchasePassive(pList[index]);
            },
            leading: Icon(Icons.description),
            enabled: !pList[index].active,
            title: Text("Passive $index"),
            subtitle: Text(pList[index].toString()),
            trailing: FlatButton(
              child: Text("Buy"),
              clipBehavior: Clip.antiAlias,
              autofocus: true,
              color: _passiveButtonColor(pList[index]),
              onPressed: () => purchasePassive(pList[index]),
              shape: RoundedRectangleBorder(),
            ),
          );
        },
      ),
    );
  }

  Color _passiveButtonColor(Passive p) {
    if (!p.isActive()) {
      return Colors.green;
    } else {
      return Colors.grey;
    }
  }
}
