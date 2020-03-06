import 'dart:math';

import 'package:risk/models/gameStateObjects/tile.dart';

class GameBoard{
    final int dimensions = (new Random().nextInt(9) + 7);
    List<Tile> tiles = new List();
}