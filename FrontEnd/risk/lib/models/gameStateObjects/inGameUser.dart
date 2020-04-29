import 'package:flutter/foundation.dart';
import 'package:risk/models/gameStateObjects/game.dart';
import 'package:risk/models/gameStateObjects/passive.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:risk/src/utils/serviceProviders.dart';

part 'inGameUser.g.dart';

@JsonSerializable(explicitToJson: true)
class InGameUser {
  List<Tile> ownedTiles = List<Tile>();
  int money;
  List<Passive> ownedPassives = List<Passive>();
  double troopMultiplier;
  double moneyMultiplier;
  int genTroops;
  int genMoney;
  String userName;
  String faction;
  int turnID; // <- also used for turn id
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
      @required this.turnID,
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
  void purchasePassive(Passive p, int currUser) {
    if (canAfford(p) && !p.isActive()) {
      p.purchase(currUser);
      ownedPassives.add(p);
      money -= p.getCost();
    }
  }

/**
 * sells a passive object
 * removes the modifiers from the user and sets the passive status to false
 * returns -1 if the passive did not belong to this user
 */
  int sellPassive(Passive p) {
    if (ownedPassives.contains(p)) {
      ownedPassives.remove(p);
      return p.sell();
    }
    return -1;
  }

  /**
   * resets the current passiveModifiers applies the modifiers of the current ownedPassive objects to the inGameUser
   */
  void updateModifiers() {
    this.moneyMultiplier = 0;
    this.troopMultiplier = 0;
    for (int i = 0; i < this.ownedPassives.length; i++) {
      if (ownedPassives.elementAt(i).modifiedValue == PassiveModifiers.attack) {
        // this applies to tiles not users, do nothing
      } else if (ownedPassives.elementAt(i).modifiedValue ==
          PassiveModifiers.defense) {
        // this applies to tiles not users, do nothing
      } else if (ownedPassives.elementAt(i).modifiedValue ==
          PassiveModifiers.moneyGeneration) {
        this.moneyMultiplier += (.01 * ownedPassives.elementAt(i).passiveValue);
      } else if (ownedPassives.elementAt(i).modifiedValue ==
          PassiveModifiers.troopGeneration) {
        this.troopMultiplier += (.01 * ownedPassives.elementAt(i).passiveValue);
      }
    }
  }
}
