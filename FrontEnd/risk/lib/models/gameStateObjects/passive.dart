
import 'package:json_annotation/json_annotation.dart';

part 'passive.g.dart';

@JsonSerializable(explicitToJson: true)
class Passive {
  int cost;
  int duration;
  bool active;
  int passiveValue;
  PassiveModifiers modifiedValue;

  Passive(this.cost, this.duration, this.active, this.passiveValue, this.modifiedValue);

    factory Passive.fromJson(Map<String, dynamic> json) => _$PassiveFromJson(json);
    Map<String, dynamic> toJson() => _$PassiveToJson(this);
}

enum PassiveModifiers { defense, attack, troopGeneration, moneyGeneration }
