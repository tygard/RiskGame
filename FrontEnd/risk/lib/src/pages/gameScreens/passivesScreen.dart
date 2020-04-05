import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:risk/models/gameStateObjects/active.dart';
import 'package:risk/models/gameStateObjects/passive.dart';
import 'package:risk/models/gameStateObjects/gameState.dart';
import 'package:risk/src/utils/serviceProviders.dart';

import '../../../models/gameStateObjects/game.dart';

class PassivesScreen extends StatefulWidget {
  Tile selectedTile;

  List<Passive> passivesList = List<Passive>();
  List<Active> activesList = List<Active>();
  /**
   * a passives screen takes an optional tile parameter
   * it displays 5 randomly generated passive objects under the passives tab
   * along with any passives that the current user owns
   * 
   * if given a selectedTile then 5 random actives and the actives owned by
   * that tile are displayed under the actives tab
   */
  PassivesScreen({this.selectedTile}) {
    if (this.selectedTile != null) {
      this.activesList = selectedTile.activesList;
    }

    for (int i = 0; i < 5; i++) {
      activesList.add(new Active());
      passivesList.add(new Passive());
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
  void purchaseActive(Active a, Tile selTile) {
    setState(() {
      for (int i = 0; i < locator<GameState>().board.tiles.length; i ++){
        if (locator<GameState>().board.tiles.elementAt(i) == selTile){
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
            _createModifierList(widget.passivesList),
            _createModifierList(widget.activesList),
          ]),
        ),
      ),
    );
  }

  /**
   * creates a list of modifiers to be displayed to the user
   * if there is no selected tile and this list is for the active objects
   * display a message to select a tile to view actives
   */
  Widget _createModifierList(mList) {
    String itemType;
    if (mList[0].runtimeType == Active) {
      itemType = "Actives";
      if (widget.selectedTile == null) {
        return Center(
          child: Text("Select a tile from the Game Board to view actives"),
        );
      }
    } else if (mList[0].runtimeType == Passive) {
      itemType = "Passives";
    }
    return Container(
      alignment: Alignment.bottomLeft,
      child: ListView.builder(
        itemCount: mList.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.description),
            enabled: !mList[index].isActive(),
            title: Text("$itemType $index"),
            subtitle: Text(mList[index].toString()),
            trailing: FlatButton(
              child: Text(_buttonString(mList[index])),
              clipBehavior: Clip.antiAlias,
              autofocus: true,
              color: _modifierButtonColor(mList[index]),
              onPressed: () => purchaseActive(mList[index], widget.selectedTile),
              shape: RoundedRectangleBorder(),
            ),
          );
        },
      ),
    );
  }

  String _buttonString(listItem){
    if (!listItem.isActive()){
      return "Buy";
    } else if (listItem.isActive()){
      return "Owned";
    }

  }

  Color _modifierButtonColor(listItem) {
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
