import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:risk/models/gameStateObjects/active.dart';
import 'package:risk/models/gameStateObjects/passive.dart';
import 'package:risk/models/gameStateObjects/gameState.dart';
import 'package:risk/src/utils/serviceProviders.dart';

import '../../../models/gameStateObjects/game.dart';

class PassivesScreen extends StatefulWidget {
  List<Passive> passivesList = List<Passive>();
  List<Active> activesList = List<Active>();
  /**
   * a passive screen needs a list of passives, usually the InGameUsers owned passives 
   * FOR TESTING: if there is no passive list given it populates passivesList with 5 random passives, 1 for actives
   */
  PassivesScreen({this.passivesList, this.activesList}) {
    if (passivesList == null || passivesList.length == 0) {
      this.passivesList = new List<Passive>();
      this.passivesList.add(new Passive());
      this.passivesList.add(new Passive());
      this.passivesList.add(new Passive());
      this.passivesList.add(new Passive());
      this.passivesList.add(new Passive());
    }
    if (activesList == null || passivesList.length == 0) {
      this.activesList = new List<Active>();
      this.activesList.add(new Active());
    }
  }

  @override
  _PassivesScreenState createState() => _PassivesScreenState();
}

class _PassivesScreenState extends State<PassivesScreen> {
  /**
   * calls this users purchasePassive function with the Passive p
   */
  void purchasePassive(Passive p) {
    setState(() {
      locator<GameState>()
          .users[locator<GameState>().currPlayer]
          .purchasePassive(p, locator<GameState>().currPlayer);
    });
  }

/**
 * calls the chosen tiles purchase 
 */
  void purchaseActive(Active a, int selectedTileIndex) {
    setState(() {
      locator<GameState>()
          .board
          .tiles
          .elementAt(selectedTileIndex)
          .purchaseActive(a);
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
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Modifiers"),
            leading: BackButton(
              onPressed: () => Navigator.pop(context),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: TabBar(tabs: [
                Tab(text: "Passives"),
                Tab(text: "Actives"),
              ]),
            ),
          ),
          body: TabBarView(children: [
            _createPassivesList(widget.passivesList),
            _createActiveList(widget.activesList),
          ]),
        ),
      ),
    );
  }

  Widget _createActiveList(List<Active> aList) {
    return Container(
      alignment: Alignment.bottomLeft,
      child: ListView.builder(
        itemCount: aList.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.description),
            enabled: !aList[index].isActive(),
            title: Text("Active $index"),
            subtitle: Text(aList[index].toString()),
            trailing: FlatButton(
              child: Text("Buy"),
              clipBehavior: Clip.antiAlias,
              autofocus: true,
              color: _activeButtonColor(aList[index]),
              // TODO: add reference to selected tile in place of '0'
              onPressed: () => purchaseActive(aList[index], 0),
              shape: RoundedRectangleBorder(),
            ),
          );
        },
      ),
    );
  }

  Widget _createPassivesList(List<Passive> pList) {
    return Container(
      alignment: Alignment.bottomLeft,
      child: ListView.builder(
        itemCount: pList.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.description),
            enabled: !pList[index].isActive(),
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
    // if the passive isnt active and the current user has more money than the cost of the passive

    /*  ---------------------------------------------------------------------------------------
    FOR TESTING: the second expression is commented out bc the server is not currently running
    --------------------------------------------------------------------------------------- */

    if (!p.isActive() /* &&
        p.getCost() <
            locator<GameState>().users[locator<GameState>().currPlayer].money */
        ) {
      return Colors.green;
    } else {
      return Colors.grey;
    }
  }

  Color _activeButtonColor(Active a) {
    // if the active isnt active and the current user has more money than the cost of the active

    /*  ---------------------------------------------------------------------------------------
    FOR TESTING: the second expression is commented out bc the server is not currently running
    --------------------------------------------------------------------------------------- */

    if (!a.isActive() /* &&
        a.getCost() <
            locator<GameState>().users[locator<GameState>().currPlayer].money */
        ) {
      return Colors.green;
    } else {
      return Colors.grey;
    }
  }
}
