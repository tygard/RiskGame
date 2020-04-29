import 'package:flutter/foundation.dart';
import 'package:risk/models/gameStateObjects/game.dart';
import 'package:risk/models/gameStateObjects/gameState.dart';
import 'package:risk/src/utils/serviceProviders.dart';

import 'package:json_annotation/json_annotation.dart';

part 'tile.g.dart';

@JsonSerializable(explicitToJson: true)
class Tile {
  int x;
  int y;

  //an int from -2 to 3 inclusive, with -2 being an immovable tile and -1 being a uncaptured tile.
  //ints 0, 1, 2, 3 are refrences to player nums.
  int ownership;
  int troops;
  int power;
  int defense;

  // actives that are applied to this tile
  List<Active> activesList = List<Active>();

  //per turn generation of money or troop
  int moneyGeneration;
  int troopGeneration;

  /**
   * creates a new tile object with coordinats of x, y
   * ownership defaults to -1 (uncaptured tile)
   */
  Tile(@required this.x, @required this.y,
      {this.ownership,
      this.troops,
      this.power,
      this.defense,
      this.moneyGeneration,
      this.troopGeneration}) {
    switch (this.ownership) {
      case -3:
        {
          this.power = 0;
          this.defense = 0;
          this.moneyGeneration = 0;
          this.troopGeneration = 0;
        }
        break;
      case -2:
        {
          this.power = 0;
          this.defense = 0;
          this.moneyGeneration = 0;
          this.troopGeneration = 0;
        }
        break;

      case -1:
        {
          this.power = 1;
          this.defense = 1;
          this.moneyGeneration = locator<GameState>().AITileGrowth;
          //this.troopGeneration = locator<GameState>().AITileGrowth;
        }
        break;

      default:
        this.power = 1;
        this.defense = 1;
        this.moneyGeneration = locator<GameState>().tileGrowthPercent;
        //this.troopGeneration = locator<GameState>().initArmyNum;
    }
  }
  factory Tile.fromJson(Map<String, dynamic> json) => _$TileFromJson(json);
  Map<String, dynamic> toJson() => _$TileToJson(this);

  /**
   * adds the Active a to this tiles activesList, assigns the actives tile property to this tile
   */
  void purchaseActive(Active a) {
    this.activesList.add(a);
  }

  /**
   * removes an Active a from this tiles activesList, removes the actives reference to its owning tile
   * returns the cost of the active
   * returns -1 if active did not belong to the tile
   */
  int sellActive(Active a) {
    if (activesList.contains(a)) {
      a.duration = -1;
      activesList.remove(a);
    }
    return -1;
  }


  /**
   * resets the attributes of this tile to their defaults, applies all of the current actives to the tile
   */
  void updateModifiers() {
    switch (this.ownership) {
      case -3:
        {
          this.power = 0;
          this.defense = 0;
          this.moneyGeneration = 0;
          this.troopGeneration = 0;
        }
        break;
      case -2:
        {
          this.power = 0;
          this.defense = 0;
          this.moneyGeneration = 0;
          this.troopGeneration = 0;
        }
        break;

      case -1:
        {
          this.power = 1;
          this.defense = 1;
          this.moneyGeneration = locator<GameState>().AITileGrowth;
          //this.troopGeneration = locator<GameState>().AITileGrowth;
        }
        break;

      default:
        this.power = 1;
        this.defense = 1;
        this.moneyGeneration = locator<GameState>().tileGrowthPercent;
        //this.troopGeneration = locator<GameState>().initArmyNum;
    }
    for (int i = 0; i < this.activesList.length; i++) {
      this.defense += this.activesList.elementAt(i).defense;
      this.power += this.activesList.elementAt(i).power;
    }
  }
}
