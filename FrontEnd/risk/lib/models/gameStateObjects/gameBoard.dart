import 'dart:math';

import 'package:risk/models/gameStateObjects/tile.dart';

class GameBoard {
  final int dimensions = (new Random().nextInt(9) + 7);
  List<Tile> tiles = new List();

  GameBoard() {
    _populateTiles();
  }
  void _populateTiles() {
    for (int x = 0; x < this.dimensions; x++) {
      for (int y = 0; y < this.dimensions; y++) {
        tiles.add(new Tile(x, y));
      }
    }
  }
}