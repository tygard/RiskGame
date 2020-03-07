import 'package:risk/models/gameStateObjects/game.dart';
import 'package:risk/models/gameStateObjects/gameState.dart';

class Tile {
  int x;
  int y;

  //an int from -2 to 3 inclusive, with -2 being an immovable tile and -1 being a uncaptured tile.
  //ints 0, 1, 2, 3 are refrences to player nums.
  int ownership;
  int troops;
  int power;
  int defense;

  //per turn generation of money or troop
  int moneyGeneration;
  int troopGeneration;

  /**
   * creates a new tile object with coordinats of x, y
   * ownership defaults to -1, troops defaults to 5
   * TODO: default params should probably reference inits in GameState but I
   * dont know how the gameController will handle the instance of gameState yet
   */
  Tile(this.x, this.y,
      {this.ownership = -1,
      this.troops = 5,
      this.power,
      this.defense,
      this.moneyGeneration,
      this.troopGeneration});
}
