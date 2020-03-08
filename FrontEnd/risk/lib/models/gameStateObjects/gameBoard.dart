import 'dart:math';
import 'package:risk/models/gameStateObjects/tile.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:risk/models/gameStateObjects/tile.dart';

part 'gameBoard.g.dart';

@JsonSerializable(explicitToJson: true)
class GameBoard {
  int dimensions = (new Random().nextInt(9) + 7);
  List<Tile> tiles = new List();

  GameBoard(this.dimensions, this.tiles) {
    _createTiles();
  }

  factory GameBoard.fromJson(Map<String, dynamic> json) =>
      _$GameBoardFromJson(json);
  Map<String, dynamic> toJson() => _$GameBoardToJson(this);

  void _createTiles() {
    for (int x = 0; x < this.dimensions; x++) {
      for (int y = 0; y < this.dimensions; y++) {
        tiles.add(new Tile(x, y));
      }
    }
  }
}
