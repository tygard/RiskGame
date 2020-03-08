import 'dart:math';
import 'package:risk/models/gameStateObjects/game.dart';
import 'package:risk/models/gameStateObjects/tile.dart';
import 'package:risk/models/gameStateObjects/gameState.dart';
import 'package:risk/models/gameStateObjects/InGameUser.dart';

enum PassiveModifiers {
  none,
  defense,
  attack,
  troopGeneration,
  moneyGeneration
}

/**
 * passives are modifiers that apply to users and can be purchased by a user
 * from the passives screen
 */
class Passive {
  int cost = 0;
  int owner = -1;
  bool active = false;
  int passiveValue = 0;
  PassiveModifiers modifiedValue = PassiveModifiers.none;

  /**
   *  --- if any parameters are left blank, assigns values in the following ranges ---
   * cost = [50-250]
   * passiveValue = [1-10]
   * modifiedValue = [defense, attack, troopGeneration, moneyGeneration]
   */
  Passive({int cost, int passiveValue, PassiveModifiers modifiedValue}) {
    if (cost == null) {
      cost = new Random().nextInt(201) + 50; // random goes from 0 to max, exclusive
    } else {
      this.cost = cost;
    }
    if (passiveValue == null) {
      passiveValue = new Random().nextInt(10) + 1;
    } else {
      this.passiveValue = passiveValue;
    }
    if (modifiedValue == null) {
      this.modifiedValue = _determineModifier(new Random().nextInt(4));
    } else {
      this.modifiedValue = modifiedValue;
    }
  }

  void setActive() {
    active = true;
  }

  void setInActive() {
    active = false;
  }

  /**
   * returns active state of the passive object
   */
  bool isActive() {
    return (active);
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
          return modifiedValue = PassiveModifiers.defense;
        }
        break;

      case 1:
        {
          return modifiedValue = PassiveModifiers.attack;
        }
        break;

      case 2:
        {
          return modifiedValue = PassiveModifiers.troopGeneration;
        }
        break;

      case 3:
        {
          return modifiedValue = PassiveModifiers.moneyGeneration;
        }
        break;

      default:
        return PassiveModifiers.defense; // this should never happen
    }
  }
}
