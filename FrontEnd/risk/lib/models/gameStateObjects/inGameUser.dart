import 'package:json_annotation/json_annotation.dart';

import 'passive.dart';

part 'inGameUser.g.dart';

@JsonSerializable(explicitToJson: true)
class InGameUser {
    List<Passive> passives = List<Passive>();

    InGameUser(this.passives);


    factory InGameUser.fromJson(Map<String, dynamic> json) => _$InGameUserFromJson(json);
    Map<String, dynamic> toJson() => _$InGameUserToJson(this);
}
