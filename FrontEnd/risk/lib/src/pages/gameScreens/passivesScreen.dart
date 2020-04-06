import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:risk/gameLayer/globalVars.dart';
import 'package:risk/models/gameStateObjects/active.dart';
import 'package:risk/models/gameStateObjects/passive.dart';
import 'package:risk/models/gameStateObjects/gameState.dart';
import 'package:risk/src/utils/serviceProviders.dart';

import '../../../models/gameStateObjects/game.dart';

/**
   * a passives screen takes an optional tile parameter
   * it displays 5 randomly generated passive objects under the passives tab
   * along with any passives that the current user owns
   * 
   * if given a selectedTile then 5 random actives and the actives owned by
   * that tile are displayed under the actives tab
   */
class PassivesScreen extends StatefulWidget {
  final Tile selectedTile;

  PassivesScreen({this.selectedTile});

  @override
  _PassivesScreenState createState() => _PassivesScreenState(this.selectedTile);
}

class _PassivesScreenState extends State<PassivesScreen> {
  Tile sTile;
  List<Passive> passivesList = List<Passive>();
  List<Active> activesList = List<Active>();
  GameState gs;
  InGameUser u;

  _PassivesScreenState(this.sTile);

  @override
  void initState() {
    // if the number of users is 0 there will be nothing to base this screen around
    if (locator<GameState>().users.length != 0) {
      if (sTile != null) {
        activesList = sTile.activesList;
      }
      gs = locator<GameState>();
      passivesList = gs.users.elementAt(gs.currPlayer).ownedPassives;

      // generate 5 random actives and passives to their respective lists
      for (int i = 0; i < 5; i++) {
        activesList.add(new Active());
        passivesList.add(new Passive());
      }
    }
  }

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
  void purchaseActive(Active a, Tile selTile) {
    setState(() {
      for (int i = 0; i < locator<GameState>().board.tiles.length; i++) {
        if (locator<GameState>().board.tiles.elementAt(i) == selTile) {
          locator<GameState>().board.tiles.elementAt(i).purchaseActive(a);
        }
      }
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
              preferredSize: Size.fromHeight(10),
              child: Container(
                height: 35,
                child: TabBar(tabs: [
                  Tab(text: "Passives"),
                  Tab(text: "Actives"),
                ]),
              ),
            ),
          ),
          body: TabBarView(children: [
            _createPassivesList(passivesList),
            _createActivesList(activesList),
          ]),
        ),
      ),
    );
  }

  /**
   * creates a list of passives to be displayed to the user
   */
  Widget _createPassivesList(List<Passive> mList) {
    if (locator<GameState>().users.length == 0) {
      return Center(
        child: Text("GameState was not initialized properly, no users exist\n" +
            "Users = ${locator<GameState>().users}\tCurrplayer = ${locator<GameState>().currPlayer}"),
      );
    }
    return Container(
      alignment: Alignment.bottomLeft,
      child: ListView.builder(
        itemCount: mList.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return new Column(
              children: <Widget>[
                Text(
                  "\nCurrent User Stats: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "Troop Generation: ${locator<GameState>().users[locator<GameState>().currPlayer].genTroops}, " +
                      "Money Generation: ${locator<GameState>().users[locator<GameState>().currPlayer].genMoney}, ",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                )
              ],
            );
          }
          index -= 1;
          return ListTile(
            leading: Icon(Icons.description),
            enabled: !mList[index].isActive(),
            title: Text("Passive $index"),
            subtitle: Text(mList[index].toString()),
            trailing: FlatButton(
              child: Text(_buttonString(mList[index])),
              clipBehavior: Clip.antiAlias,
              autofocus: false,
              color: _modifierButtonColor(mList[index]),
              onPressed: () => purchasePassive(mList[index]),
              shape: RoundedRectangleBorder(),
            ),
          );
        },
      ),
    );
  }

  /**
   * creates a list of actives to be displayed to the user
   * if there is no selected tile and this list is for the active objects
   * display a message to select a tile to view actives
   */
  Widget _createActivesList(List<Active> mList) {
    if (sTile == null) {
      return Center(
        child: Text("Select a Tile on the Gameboard to view Actives"),
      );
    }
    return Container(
      alignment: Alignment.bottomLeft,
      child: ListView.builder(
        itemCount: mList.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return new Column(
              children: <Widget>[
                Text(
                  "\nCurrent Tile Stats: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "X: ${sTile.x}, Y: ${sTile.y}, " +
                      "Power: ${sTile.power}, Defense: ${sTile.defense}\n",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                )
              ],
            );
          }
          index -= 1;
          return ListTile(
            leading: Icon(Icons.description),
            enabled: !mList[index].isActive(),
            title: Text("Active $index"),
            subtitle: Text(mList[index].toString()),
            trailing: FlatButton(
              child: Text(_buttonString(mList[index])),
              clipBehavior: Clip.antiAlias,
              autofocus: false,
              color: _modifierButtonColor(mList[index]),
              onPressed: () => purchaseActive(mList[index], sTile),
              shape: RoundedRectangleBorder(),
            ),
          );
        },
      ),
    );
  }

  String _buttonString(dynamic listItem) {
    if (!listItem.isActive()) {
      return "Buy";
    } else if (listItem.isActive()) {
      return "Owned";
    }
    return "Error";
  }

  Color _modifierButtonColor(dynamic listItem) {
    // if the passive isnt active and the current user has more money than the cost of the passive

    /*  ---------------------------------------------------------------------------------------
    FOR TESTING: the second expression is commented out bc the server is not currently running
    --------------------------------------------------------------------------------------- */

    if (!listItem
            .isActive() /* &&
        listItem.getCost() <
            locator<GameState>().users[locator<GameState>().currPlayer].money */
        ) {
      return Colors.green;
    } else {
      return Colors.grey;
    }
  }
}
