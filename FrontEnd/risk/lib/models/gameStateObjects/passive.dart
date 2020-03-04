import 'dart:math';
import 'package:risk/models/gameStateObjects/tile.dart';
import 'package:risk/models/gameStateObjects/gameState.dart';

enum PassiveModifiers { defense, attack, troopGeneration, moneyGeneration }

/**
 * passives are modifiers that apply to tiles under control of a user
 */
class Passive {
  Tile curTile;
  int cost;
  int duration;
  bool active;
  int passiveValue;
  PassiveModifiers modifiedValue;

  /**
   * generates a passive object assigned to a Tile() 
   * TODO: restructure tiles to be the objects modified by passives, not users
   *  --- if any parameters are left blank, assigns values in the following ranges ---
   * cost = [50-250]
   * duration = [3-15]
   * passiveValue = [1-10]
   * modifiedValue = [defense, attack, troopGeneration, moneyGeneration]
   */
  Passive(this.curTile, {int c, int d, int pV, int mV}) {
    if (c == 0) {
      cost = Random().nextInt(201) + 50; // random goes from 0 to max, exclusive
    } else {
      cost = c;
    }
    if (d == 0) {
      duration = Random().nextInt(13) + 3;
    } else {
      duration = d;
    }
    if (pV == 0) {
      passiveValue = Random().nextInt(10) + 1;
    } else {
      passiveValue = pV;
    }
    if (mV == 0) {
      modifiedValue = _determineModifier(Random().nextInt(4));
    } else {
      modifiedValue = _determineModifier(mV);
    }
  }

  /**
   * advanceTurn is called everytime the gameState's turn updates.
   * Decrements remaining duration of the passive if it is active,
   * de activates the passive when remaining duration reaches zero
   */
  void advanceTurn() {
    if (!isActive()){
      return;
    } else 
    if (duration == 0) {
      deActivate();
    }
  }

  void purchase(){


    if (modifiedValue == PassiveModifiers.attack){
      curTile.power += passiveValue;
    }
    else if (modifiedValue == PassiveModifiers.defense){
      curTile.defense += passiveValue;
    }
    else if (modifiedValue == PassiveModifiers.moneyGeneration){
      curTile.moneyGeneration += passiveValue;
    }
    else if (modifiedValue == PassiveModifiers.troopGeneration){
      curTile.troopGeneration += passiveValue;
    }
  }

  /**
   * passive is no longer active, 
   */
  void deActivate() {
    duration = -1;
    passiveValue = 0;
  }

  /**
   * returns active state of the passive object
   */
  bool isActive() {
    return (active);
  }

  String toString() {
    String s;
    s = "Cost: ${cost}\n"
    s += "Duration: ${duration}\n";
    s += "Modifier: ${modifiedValue}";
    s += "Value: ${passiveValue}";
    return s;
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
