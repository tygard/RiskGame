import 'dart:math';

import 'package:json_annotation/json_annotation.dart';

part 'passive.g.dart';

enum PassiveModifiers {
  none,
  defense,
  attack,
  troopGeneration,
  moneyGeneration
}

@JsonSerializable(explicitToJson: true)
/**
 * passives are modifiers that apply to users and can be purchased by a user
 * from the passives screen
 */
class Passive {
  int cost = 0;
  int owner = -1;
  bool active = false;
  int passiveValue = 0;
  int duration; // not used, left in just in case it needs to be parsed for the gameState
  PassiveModifiers modifiedValue = PassiveModifiers.none;

  /**
   *  --- if any parameters are left blank, assigns values in the following ranges ---
   * cost = [50-250]
   * passiveValue = [1-10]
   * modifiedValue = [defense, attack, troopGeneration, moneyGeneration]
   */
  Passive({int cost, int passiveValue, PassiveModifiers modifiedValue}) {
    if (cost == null) {
      this.cost = new Random().nextInt(200) +
          51; // random goes from 0 to max, exclusive
    } else {
      this.cost = cost;
    }
    if (passiveValue == null) {
      this.passiveValue = new Random().nextInt(10) + 1;
    } else {
      this.passiveValue = passiveValue;
    }
    if (modifiedValue == null) {
      this.modifiedValue = _determineModifier(new Random().nextInt(2));
    } else {
      this.modifiedValue = modifiedValue;
    }
    this.active = false;
  }

  factory Passive.fromJson(Map<String, dynamic> json) =>
      _$PassiveFromJson(json);
  Map<String, dynamic> toJson() => _$PassiveToJson(this);

  /**
   * assigns an owner to a passive
   */
  void purchase(int owner) {
    this.owner = owner;
    this.active = true;
  }

  /**
   * removes reference to this passive, return the cost
   */
  int sell() {
    this.owner = null;
    this.active = false;
    return this.cost;
  }

  int getCost() {
    return this.cost;
  }

  /**
   * returns active state of the passive object
   */
  bool isActive() {
    return this.active;
  }

  /**
   * returns a string description of this passive
   */
  String toString() {
    String s = "Cost: $cost, \t";
    s += _modifierToString(this.modifiedValue);
    s += " + $passiveValue%";
    return s;
  }

  String _modifierToString(PassiveModifiers pM) {
    if (pM == PassiveModifiers.attack)
      return "Attack";
    else if (pM == PassiveModifiers.defense)
      return "Defense";
    else if (pM == PassiveModifiers.troopGeneration)
      return "Troop Generation";
    else if (pM == PassiveModifiers.moneyGeneration)
      return "Money Generation";
    else
      return "Not a valid Modifier";
  }

  PassiveModifiers _determineModifier(int mVal) {
    switch (mVal) {
      case 0:
        {
          return modifiedValue = PassiveModifiers.troopGeneration;
        }
        break;

      case 1:
        {
          return modifiedValue = PassiveModifiers.moneyGeneration;
        }
        break;

      default:
        return PassiveModifiers.none; // this should never happen
    }
  }
}
