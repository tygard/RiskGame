import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:risk/models/gameStateObjects/tile.dart';

part 'gameBoard.g.dart';

@JsonSerializable(explicitToJson: true)
class GameBoard {
  int dimensions;
  List<Tile> tiles = new List();

  GameBoard(this.dimensions, this.tiles);

  factory GameBoard.fromJson(Map<String, dynamic> json) =>
      _$GameBoardFromJson(json);
  Map<String, dynamic> toJson() => _$GameBoardToJson(this);
}
