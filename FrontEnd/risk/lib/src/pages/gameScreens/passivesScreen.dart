import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:risk/models/gameStateObjects/active.dart';
import 'package:risk/models/gameStateObjects/passive.dart';
import 'package:risk/models/gameStateObjects/gameState.dart';
import 'package:risk/src/utils/serviceProviders.dart';
import 'package:risk/gameLayer/globalVars.dart';
import 'package:risk/gameLayer/Tile.dart' as _TileState;
import 'package:risk/models/gameStateObjects/tile.dart' as tileObject;

/**
   * a passives screen takes an optional tile parameter
   * it displays 5 randomly generated passive objects under the passives tab
   * along with any passives that the current user owns
   * 
   * if given a selectedTile then 5 random actives and the actives owned by
   * that tile are displayed under the actives tab
   */
class PassivesScreen extends StatefulWidget {
  PassivesScreen();

  @override
  _PassivesScreenState createState() => _PassivesScreenState();
}

class _PassivesScreenState extends State<PassivesScreen> {
  List<Passive> passivesList = new List<Passive>();
  List<Active> activesList = new List<Active>();
  _TileState.Tile prevtWidget;
  _TileState.Tile tWidget;
  tileObject.Tile sTile;
  int curTurn;
  int pTurn;

  void locateTile() {
    // if there is a selected tileWidget, find the tileObject that is represented by that tile widget
    if (tWidget != null) {
      loop:
      for (int i = 0; i < locator<GameState>().board.tiles.length; i++) {
        if (locator<GameState>().board.tiles.elementAt(i).x == tWidget.x &&
            locator<GameState>().board.tiles.elementAt(i).y == tWidget.y) {
          sTile = locator<GameState>().board.tiles.elementAt(i);
          break loop;
        }
      }
    }
  }

  void resetState() {
    passivesList = new List<Passive>();
    activesList = new List<Active>();
    makeState();
  }

  void makeState() {
    locateTile();
    if (sTile != null) {
      // --------------------- 
      // need to add something to not add duplicates to the activesList, 
      // also somthing else that i cant remember
      activesList.insertAll(0, sTile.activesList);

      // generate 5 random actives to their respective lists
      for (int i = 0; i < 5; i++) {
        activesList.add(new Active());
      }
    }

    // if the number of users is 0 there will be nothing to base the passives tab around
    // otherwise we can create the passivesList
    if (locator<GameState>().users.length != 0) {
      passivesList.insertAll(
          0,
          locator<GameState>()
              .users
              .elementAt(locator<GameState>().currPlayer)
              .ownedPassives);

      // generate 5 random passives to their respective lists
      for (int i = 0; i < 5; i++) {
        passivesList.add(new Passive());
      }
    }
  }

  @override
  void initState() {
    tWidget = selectedTile;
    curTurn = locator<GameState>().turn;

    // if the previous widget that opened the passiveScreen is the same as the current widget, keep the same state
    // if the previous widget is not the same as the current widget, recreate the state of the passivesScreen
    // if there was a previous widget and it is the same as the current widget, do nothing
    if (prevtWidget == null) {
      prevtWidget = tWidget;
      makeState();
    } else if (prevtWidget != tWidget) {
      resetState();
    }

    // if there was a previous turn where passivesScreen was created
    // if the previous turn was a different turn we need to recreate the state of the screen
    // if there was a previous turn and it is still that turn, do nothing
    if (pTurn == null) {
      pTurn = curTurn;
      makeState();
    } else if (pTurn != curTurn) {
      resetState();
    }
  }

  /**
   * calls this users purchasePassive function with the Passive p
   */
  void purchasePassive(Passive p) {
    setState(() {
      locator<GameState>()
          .users
          .elementAt(locator<GameState>().currPlayer)
          .purchasePassive(p, locator<GameState>().currPlayer);
    });
  }

/**
 * calls the chosen tiles purchase 
 */
  void purchaseActive(Active a, tileObject.Tile selTile) {
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
