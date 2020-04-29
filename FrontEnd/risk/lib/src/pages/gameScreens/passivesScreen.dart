import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:risk/models/freezedClasses/user.dart';
import 'package:risk/models/gameStateObjects/active.dart';
import 'package:risk/models/gameStateObjects/game.dart';
import 'package:risk/models/gameStateObjects/passive.dart';
import 'package:risk/models/gameStateObjects/gameState.dart';
import 'package:risk/src/utils/serviceProviders.dart';
import 'package:risk/gameLayer/globalVars.dart';
import 'package:risk/gameLayer/Tile.dart';
import 'package:risk/models/gameStateObjects/tile.dart';

/** 

   * a passives screen takes an optional tile parameter
   * it displays 5 randomly generated passive objects under the passives tab
   * along with any passives that the current user owns
   * 
   * if given a selectedTile then 5 random actives and the actives owned by
   * that tile are displayed under the actives tab, along with any actives that the current tile owns
   */
class PassivesScreen extends StatefulWidget {
  PassivesScreen();

  @override
  _PassivesScreenState createState() => _PassivesScreenState();
}

class _PassivesScreenState extends State<PassivesScreen> {
  Tile sTile;
  String s = "";
  int curTurn;
  int c = 0;
  InGameUser curUser;
  @override
  void initState() {
    super.initState();
    curTurn = locator<GameState>().turn;
    curUser = _findCurUser();
    _setSTile();
    /**
     * first entry
     *  no tile
     *  yes tile
     * not first entry
     *  no tile
     *  same turn
      *    no tile 
      *    yes tile
      *      new tile
      *      not new tile
     *  diff turn
     *    no tile
     *    yes tile
     */
    print(
        "before:\ns: \"$s\", pTurn: $pTurn, cTurn: $curTurn, tOffset: $tOffset, sTile: $sTile, \npList: $passivesList\naList: $activesList\nownedPassives: ${curUser.ownedPassives}----------------------------------->>>>>");
    curUser.money +=
        100; //JUST TO TEST PURCHASING------------------------------

    if (pTurn == curTurn) {
      // same turn, check tile properties, not passives
      s = "same turn: ";
      if (tOffset == null) {
        // no tile selected, set sTile to null
        s += "no tile selected";
        sTile = null;
      } else {
        // tile selected, locate this tile, check if actives were generated during a previous init
        s += "tile selected, ";
        _setSTile();
        if (activesList == null || activesList.length == 0) {
          // no actives list, set the actives
          s += "no actives list, set new one";
          _setActives();
        } else {
          // actives list already exists, dont set them
          s += "already actives list, dont set new one";
        }
      }
    } else {
      if (curTurn != pTurn && pTurn != -1) {
        s += "new player";
        sTile = null;
      } else {
        // new turn, reset state
        s += "new turn: reset state";
        _resetState();
      }
    }
    pTurn = curTurn;
    print(
        "after:\ns: \"$s\", pTurn: $pTurn, cTurn: $curTurn, tOffset: $tOffset, sTile: $sTile, \npList: $passivesList\naList: $activesList\nownedPassives: ${locator<GameState>().users[locator<GameState>().currPlayer].ownedPassives}----------------------------------->>>>>");
  }

  /**
   * sets sTile to the widget represented by tOffset, null if it does not exist
   */
  void _setSTile() {
    GameBoard b = locator<GameState>().board;
    if (tOffset != null) {
      for (int i = 0; i < b.tiles.length; i++) {
        if (b.tiles.elementAt(i).x == tOffset.dx &&
            b.tiles.elementAt(i).y == tOffset.dy) {
          sTile = b.tiles.elementAt(i);
          if (sTile.activesList == null) {
            sTile.activesList = new List<Active>();
          }
        }
      }
    } else {
      sTile = null;
    }
  }
/**
 * adds all actives that this tile owns to the local activesList, as well as 5 randoms the user can then purchase
 */
  void _setActives() {
    // if the sTile is null there will be nothing to base the actives tab around
    if (sTile != null) {
      if (sTile.activesList != null) {
        activesList.insertAll(0, sTile.activesList);
      } else {
        sTile.activesList = new List<Active>();
      }
      // generate 5 random actives and add to the list to be displayed
      for (int i = 0; i < 5; i++) {
        activesList.add(new Active());
      }
    }
  }
/**
 * adds the passives that the current user owns to the local passivesList, also adds 5 randoms the user can purchase
 */
  void _setPassives() {
    // if the number of users is 0 there will be nothing to base the passives tab around
    // otherwise we can create the passivesList
    if (curUser != null) {
      if (curUser.ownedPassives != null) {
        print("curUser.ownedPassive != null");
        passivesList.insertAll(0, curUser.ownedPassives);
      } else {
        print("curUser.ownedPassive == null");

        curUser.ownedPassives = new List<Passive>();
      }

      // generate 5 random passives and add to the list to be displayed
      for (int i = 0; i < 5; i++) {
        passivesList.add(new Passive());
      }
    }
  }

  /**
   * re initializes the modifier lists, sets sTile to the selected tile object, adds the current user and tile modifiers to the lists
   */
  void _resetState() {
    _setSTile();
    activesList = new List<Active>();
    _setActives();
    passivesList = new List<Passive>();
    _setPassives();
  }

/**
 * finds the current user and returns a reference
 */
  InGameUser _findCurUser() {
    for (int i = 0; i < locator<GameState>().users.length; i++) {
      if (locator<GameState>().users[i].turnID ==
          locator<User>().inGamePlayerNumber)
        return locator<GameState>().users[i];
    }
    return null;
  }

  /**
   * calls this users _purchasePassive function with the Passive p
   */
  void _purchasePassive(Passive p) {
    setState(() {
      curUser.purchasePassive(p, locator<GameState>().currPlayer);
      curUser.updateModifiers();
    });
  }

/**
 * calls the chosen tiles purchase 
 */
  void _purchaseActive(Active a, Tile selTile) {
    setState(() {
      for (int i = 0; i < locator<GameState>().board.tiles.length; i++) {
        if (locator<GameState>().board.tiles.elementAt(i) == selTile) {
          locator<GameState>().board.tiles.elementAt(i).purchaseActive(a);
          sTile.updateModifiers();
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
          body: Stack(
            children: <Widget>[
              Container(
                alignment: Alignment.topRight,
                padding: EdgeInsets.all(16),
                child: Text(
                  "Money: ${curUser.money}",
                  style: TextStyle(
                    color: Colors.yellow,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TabBarView(
                children: [
                  _createPassivesList(passivesList),
                  _createActivesList(activesList),
                ],
              ),
            ],
          ),
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
                  "\nCurrent User Stats:\n",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "Troop Generation: ${curUser.genTroops}, " +
                      "Money Generation: ${curUser.genMoney}, "
                          "Money: ${curUser.money}, "
                          "Faction: ${curUser.faction}, "
                          "Username: ${curUser.userName}, "
                          "ID: ${curUser.turnID}, "
                          "User color: ${locator<User>().color}, "
                          "InGamePlayerNumber: ${locator<User>().inGamePlayerNumber}, ",
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
              child: Text(_passiveButtonString(mList[index])),
              clipBehavior: Clip.antiAlias,
              autofocus: false,
              color: _passiveButtonColor(mList[index]),
              onPressed: () => _purchasePassive(mList[index]),
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
                  "\nCurrent Tile Stats:\n",
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
            enabled: !sTile.activesList.contains(mList[index]),
            title: Text("Active $index"),
            subtitle: Text(mList[index].toString()),
            trailing: FlatButton(
              child: Text(_activeButtonString(mList[index])),
              clipBehavior: Clip.antiAlias,
              autofocus: false,
              color: _activeButtonColor(mList[index]),
              onPressed: () => _purchaseActive(mList[index], sTile),
              shape: RoundedRectangleBorder(),
            ),
          );
        },
      ),
    );
  }

  String _passiveButtonString(Passive listItem) {
    if (!listItem.isActive()) {
      return "Buy";
    } else if (listItem.isActive()) {
      return "Owned";
    }
    return "Error";
  }

  String _activeButtonString(Active listItem) {
    if (!sTile.activesList.contains(listItem)) {
      return "Buy";
    } else if (sTile.activesList.contains(listItem)) {
      return "Owned";
    }
    return "Error";
  }

  Color _passiveButtonColor(Passive listItem) {
    // if the passive isnt active and the current user has more money than the cost of the passive
    if (!listItem.isActive() && listItem.getCost() < curUser.money) {
      return Colors.green;
    } else {
      return Colors.grey;
    }
  }

  Color _activeButtonColor(Active listItem) {
    // if the active isnt active and the current user has more money than the cost of the passive
    if (!sTile.activesList.contains(listItem) &&
        listItem.getCost() < curUser.money) {
      return Colors.green;
    } else {
      return Colors.grey;
    }
  }
}
