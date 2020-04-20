import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:risk/models/freezedClasses/user.dart';
import 'package:risk/models/gameStateObjects/active.dart';
import 'package:risk/models/gameStateObjects/game.dart';
import 'package:risk/models/gameStateObjects/passive.dart';
import 'package:risk/models/gameStateObjects/gameState.dart';
import 'package:risk/src/utils/serviceProviders.dart';
import 'package:risk/gameLayer/globalVars.dart';
import 'package:risk/gameLayer/Tile.dart' as tileDisplay;
import 'package:risk/models/gameStateObjects/tile.dart' as tileEntity;

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
  tileEntity.Tile sTile;
  String s = "";
  int curTurn;
  int c = 0;
  InGameUser curUser;
  @override
  void initState() {
    super.initState();
    tWidget = selectedTile;
    curTurn = locator<GameState>().turn;

    /* state options:
    1: this is the first time the screen is inited, previous tWidget == null, previous turn == null, pTurn ==
        - just resetState()
    b: this is not the first time the screen is inited, previous tWidget == null,         previous == turn
        - just locateTile(), setActives()
    2: this is not the first time the screen is inited, previous tWidget == this tWidget, previous == turn
        - maintain all modifiers, dont change state
    3: this is not the first time the screen is inited, previous tWidget != this tWidget, previous == turn
        - maintain all modifiers,
        - must be applied to a new tile, locateTile(), setActives()
    4: this is not the first time the screen is inited, previous tWidget == this tWidget, previous != turn
        - this is a new turn, resetState()
    5: this is not the first time the screen is inited, previous tWidget != this tWidget, previous != turn
        - this is a new turn, resetState()
*/
    print(
        "before:\ns: \"$s\", prevtW: $prevtWidget, pTurn: $pTurn, cTurn: $curTurn\n\n----------------------------------->>>>>");

    if (pTurn == -1) {
      c++;
      s = "state $c";
      resetState();
    } else {
      if ((prevtWidget == null) && (pTurn == curTurn) && (tWidget == null)) {
        s = "new entry no tile";
      } else if ((prevtWidget == null) &&
          (pTurn == curTurn) &&
          (tWidget != null)) {
        locateTile();
        setActives();
        s = "new tile";
      } else if ((prevtWidget != null) &&
          (pTurn == curTurn) &&
          (tWidget == null)) {
        s = "old tile gone, no new tile";
      } else if ((prevtWidget.position.dx == tWidget.position.dx &&
              prevtWidget.position.dy == tWidget.position.dy) &&
          (pTurn == curTurn)) {
        // dont change state
        locateTile();
        s = "no change";
      } else if (!(prevtWidget.position.dx == tWidget.position.dx &&
              prevtWidget.position.dy == tWidget.position.dy) &&
          (pTurn == curTurn)) {
        s = "changed tile";
        locateTile();
        setActives();
      } else if ((prevtWidget.position.dx == tWidget.position.dx &&
              prevtWidget.position.dy == tWidget.position.dy) &&
          (pTurn != curTurn)) {
        s = "changed turn";
        resetState();
      } else if (!(prevtWidget.position.dx == tWidget.position.dx &&
              prevtWidget.position.dy == tWidget.position.dy) &&
          (pTurn != curTurn)) {
        s = "changed tile and turn";
        resetState();
      }
      if (sTile != null) {
        prevtWidget =
            new tileDisplay.TileDisplay(position: new Offset(tWidget.position.dx, tWidget.position.dy));
      }
    }

    print(
        "after:\ns: \"$s\", prevtW: $prevtWidget, pTurn: $pTurn, cTurn: $curTurn, \ncurUser: $curUser\n\n----------------------------------->>>>>");

    pTurn = curTurn;
  }

  void locateTile() {
    // if there is a selected tileWidget, find the tileEntity that is represented by that tile widget, set sTile = to the object
    if (tWidget != null) {
      loop:
      for (int i = 0; i < locator<GameState>().board.tiles.length; i++) {
        if (locator<GameState>().board.tiles.elementAt(i).x ==
                tWidget.position.dx &&
            locator<GameState>().board.tiles.elementAt(i).y ==
                tWidget.position.dy) {
          sTile = locator<GameState>().board.tiles.elementAt(i);
          break loop;
        }
      }
    }
  }

  void setActives() {
    activesList = new List<Active>();

    // if the sTile is null there will be nothing to base the actives tab around
    if (sTile != null) {
      activesList.insertAll(0, sTile.activesList);

      // generate 5 random actives and add to the list to be displayed
      for (int i = 0; i < 5; i++) {
        activesList.add(new Active());
      }
    }
  }

  void setPassives() {
    passivesList = new List<Passive>();

    // if the number of users is 0 there will be nothing to base the passives tab around
    // otherwise we can create the passivesList
    if (locator<GameState>().users.length != 0) {
      passivesList.insertAll(0, curUser.ownedPassives);

      // generate 5 random passives and add to the list to be displayed
      for (int i = 0; i < 5; i++) {
        passivesList.add(new Passive());
      }
    }
  }

  /**
   * re initializes the modifier lists, sets sTile to the selected tile object, adds the current user and tile modifiers to the lists
   */
  void resetState() {
    passivesList = new List<Passive>();
    activesList = new List<Active>();
    locateTile();
    setActives();
    setPassives();
  }

  InGameUser findCurUser() {
    print("num users: ${locator<GameState>().users.length}");
    for (int i = 0; i < locator<GameState>().users.length; i++) {
      print(
          "user $i id: ${locator<GameState>().users[i].turnID}\tinGamePlayerNumber: ${locator<User>().inGamePlayerNumber}");
      print("user $i faction: ${locator<GameState>().users[i].faction}");
      print("user $i money: ${locator<GameState>().users[i].money}");
      print("user $i genMoney: ${locator<GameState>().users[i].genMoney}");
      print("user $i genTroops: ${locator<GameState>().users[i].genTroops}");
      print("user $i userName: ${locator<GameState>().users[i].userName}");
      print(
          "user $i troopMult: ${locator<GameState>().users[i].troopMultiplier}");
      print(
          "user $i moneyMult: ${locator<GameState>().users[i].moneyMultiplier}");
      print("user $i role: ${locator<GameState>().users[i].role}");
      print("user $i ownedTiles: ${locator<GameState>().users[i].ownedTiles}");
      print(
          "user $i ownedPassives: ${locator<GameState>().users[i].ownedPassives}\n---------------------------------------------------------------------------------------");

      if (locator<GameState>().users[i].turnID ==
          locator<User>().inGamePlayerNumber)
        return locator<GameState>().users[i];
    }
    return null;
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
  void purchaseActive(Active a, tileEntity.Tile selTile) {
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
                onPressed: () => {
                      Navigator.pop(context),
                    }),
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
    if (!listItem.isActive() && listItem.getCost() < curUser.money) {
      return Colors.green;
    } else {
      return Colors.grey;
    }
  }
}
