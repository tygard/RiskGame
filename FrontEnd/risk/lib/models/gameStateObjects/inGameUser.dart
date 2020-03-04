import 'package:risk/models/gameStateObjects/game.dart';

import 'passive.dart';

class InGameUser {
  List<Tile> ownedTiles = List<Tile>();
  int money;

  InGameUser(List<Tile> t) {
    ownedTiles = t;
  }

  /**
   * returns the status of wether the currPlayer in gameState can afford this passive
   */
  bool canAfford(Passive p) {
    return (p.cost <= money);
  }
}
