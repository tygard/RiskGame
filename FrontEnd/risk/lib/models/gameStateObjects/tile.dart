import 'package:risk/models/gameStateObjects/game.dart';

class Tile {
  int x;
  int y;

  List<Passive> passives = List<Passive>();

  //an int from -2 to 3 inclusive, with -2 being an immovable tile and -1 being a uncaptured tile.
  //ints 0, 1, 2, 3 are refrences to player nums.
  int ownership;
  int troops;
  int power;
  int defense;

  //per turn generation of money or troop
  int moneyGeneration;
  int troopGeneration;

  
}
