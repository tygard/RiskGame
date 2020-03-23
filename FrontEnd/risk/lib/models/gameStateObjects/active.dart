import 'dart:math';

import 'package:risk/models/gameStateObjects/game.dart';


/**
 * Actives are modifiers that apply to tiles for a limited number 
 * of turns, they persist through the capture of a tile and can 
 * be purchased from the modifier screen
 */
class Active{
  // the tile this active belongs to
  Tile tile;
  // duration is the number of turns the active is applied for
  int duration;
  // these modifiers are percentage bonuses applied to the corresponding attributes in tiles
  int power;
  int defense;

  /**
   * generates a random active object with no assigned Tile
   */
  Active({int power, int defense, int duration}){
    if (power == null){
      this.power = new Random().nextInt(10) + 1;
    } else {
      this.power= power;
    }
    if (defense == null){
      defense = new Random().nextInt(10) + 1;
    } else {
      this.defense = defense;
    }
    if (duration = null){
      this.duration = new Random().nextInt(10) + 1;
    } else {
      this.duration = duration;
    }
  }

  /**
   * assigns a tile to an active
   */
  void pruchase(Tile tile){
    this.tile = tile;
  }

  bool isActive(){
    return (duration > 0);
  }

  int getDuration(){
    return this.duration;
  }
}