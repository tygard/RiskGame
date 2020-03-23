import 'package:flutter/foundation.dart';
import 'package:risk/models/gameStateObjects/game.dart';
import 'package:risk/models/gameStateObjects/passive.dart';

import 'package:json_annotation/json_annotation.dart';


part 'inGameUser.g.dart';

@JsonSerializable(explicitToJson: true)
class InGameUser {
  List<Tile> ownedTiles = List<Tile>();
  int money;
  List<Passive> ownedPassives = List<Passive>();
  int troopMultiplier;
  int moneyMultiplier;
  int genTroops;
  int genMoney;
  String userName;
  String faction;
  String role;

  InGameUser(
      {@required this.ownedTiles,
      @required this.money,
      @required this.ownedPassives,
      @required this.troopMultiplier,
      @required this.moneyMultiplier,
      @required this.genTroops,
      @required this.genMoney,
      @required this.userName,
      @required this.faction,
      @required this.role});

  factory InGameUser.fromJson(Map<String, dynamic> json) =>
      _$InGameUserFromJson(json);
  Map<String, dynamic> toJson() => _$InGameUserToJson(this);

  /**
   * returns the status of wether the currPlayer in gameState can afford this passive
   */
  bool canAfford(Passive p) {
    return (p.getCost() <= money);
  }

  /**
   * purchases a passive object
   * applies the modifiers and sets the passives active status to true
   */
  void purchasePassive(Passive p) {
    if (canAfford(p) && !p.isActive()) {
      p.purchase(-1); //TODO: fix reference to the number that corresponds to this InGameUser in gameState
      ownedPassives.add(p);
    }
  }

/**
 * sells a passive object
 * removes the modifiers from the user and sets the passive status to false
 */
  void sellPassive(Passive p) {
    if (p.isActive() && ownedPassives.contains(p)) {
      p.sell();
      ownedPassives.remove(p);
    }
  }

  /**
   * applies the modifiers of the ownedPassive objects to the inGameUser
   */
  void updateModifiers(){
    for (int i = 0; i < this.ownedPassives.length; i++){
      if (ownedPassives.elementAt(i).modifiedValue == PassiveModifiers.attack){
        // this applies to tiles not users, do nothing
      } else
      if (ownedPassives.elementAt(i).modifiedValue == PassiveModifiers.defense){
        // this applies to tiles not users, do nothing
      } else
      if (ownedPassives.elementAt(i).modifiedValue == PassiveModifiers.moneyGeneration){
        this.genMoney += ownedPassives.elementAt(i).passiveValue;
      } else
      if (ownedPassives.elementAt(i).modifiedValue == PassiveModifiers.troopGeneration){
        this.genTroops += ownedPassives.elementAt(i).passiveValue;
      }
    }
  }
}