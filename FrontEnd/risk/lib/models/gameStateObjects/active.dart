import 'package:json_annotation/json_annotation.dart';
import 'dart:math';
import 'package:risk/models/gameStateObjects/game.dart';

part 'active.g.dart';

/**
 * Actives are modifiers that apply to tiles for a limited number 
 * of turns, they persist through the capture of a tile and can 
 * be purchased from the modifier screen
 */
@JsonSerializable(explicitToJson: true)
class Active {
  // the tile this active belongs to
  int cost;
  // duration is the number of turns the active is applied for
  int duration;
  // these modifiers are percentage bonuses applied to the corresponding attributes in tiles
  int power;
  int defense;

  /**
   * generates a random active object with no assigned Tile
   * power = [1-10]
   * defense = [1-10]
   * duration = [1-10]
   */
  Active({int cost, int power, int defense, int duration}) {
    if (cost == null) {
      this.cost = new Random().nextInt(200) +
          51; // random goes from 0 to max, exclusive
    } else {
      this.cost = cost;
    }
    if (power == null) {
      this.power = new Random().nextInt(10) + 1;
    } else {
      this.power = power;
    }
    if (defense == null) {
      this.defense = new Random().nextInt(10) + 1;
    } else {
      this.defense = defense;
    }
    if (duration == null) {
      this.duration = new Random().nextInt(10) + 1;
    } else {
      this.duration = duration;
    }
  }

  factory Active.fromJson(Map<String, dynamic> json) => _$ActiveFromJson(json);
  Map<String, dynamic> toJson() => _$ActiveToJson(this);

  String toString() {
    String s = "Cost: $cost, \t";
    s += "Power + $power, \t";
    s += "Defense + $defense, \t";
    s += "Duration: $duration";
    return s;
  }

  bool isActive() {
    return (duration > 0);
  }

  int getCost() {
    return this.cost;
  }

  int getDuration() {
    return this.duration;
  }
}
