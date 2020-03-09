import 'package:flutter/foundation.dart';
import 'package:risk/models/gameStateObjects/game.dart';
import 'package:risk/models/gameStateObjects/passive.dart';

import 'package:json_annotation/json_annotation.dart';


part 'InGameUser.g.dart';

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
    return (p.cost <= money);
  }

  /**
   * purchases a passive object
   * applies the modifiers and sets the passives active status to true
   */
  void purchasePassive(Passive p) {
    if (canAfford(p) && !p.isActive()) {
      if (p.modifiedValue == PassiveModifiers.attack) {
        // these apply to Tiles do nothing for now
      } else if (p.modifiedValue == PassiveModifiers.defense) {
        // these apply to Tiles do nothing for now
      } else if (p.modifiedValue == PassiveModifiers.moneyGeneration) {
        moneyMultiplier += p.passiveValue;
      } else if (p.modifiedValue == PassiveModifiers.troopGeneration) {
        troopMultiplier += p.passiveValue;
      }
      p.setActive();
      ownedPassives.add(p);
    }
  }

/**
 * sells a passive object
 * removes the modifiers from the user and sets the passive status to false
 */
  void sellPassive(Passive p) {
    if (p.isActive() && ownedPassives.contains(p)) {
      if (p.modifiedValue == PassiveModifiers.attack) {
        // these apply to Tiles do nothing for now
      } else if (p.modifiedValue == PassiveModifiers.defense) {
        // these apply to Tiles do nothing for now
      } else if (p.modifiedValue == PassiveModifiers.moneyGeneration) {
        moneyMultiplier -= p.passiveValue;
      } else if (p.modifiedValue == PassiveModifiers.troopGeneration) {
        troopMultiplier -= p.passiveValue;
      }
      p.setInActive();
      ownedPassives.remove(p);
    }
  }
}