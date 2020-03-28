
import 'dart:convert';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:risk/dataLayer/fileSystem.dart';

part 'user.g.dart';

@JsonSerializable()
class User{
  String name;
  String color;
  String email;
  String googleID;
  String uuid;

  User({this.name, this.color, this.googleID, this.uuid, this.email);

  void fromUser(User user){
    color = user.color;
    name = user.name;
    email = user.email;
    uuid = user.uuid;
    googleID = user.googleID;
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  void encode(User user) {
    writeContentToFileSystem("user.json", json.encode(this.toJson()));
  }

  void fromGoogleSignIn(GoogleSignInAccount account) {
    email = account.email;
    name = account.displayName;
    googleID = account.id;
    encode(this);
  }
}