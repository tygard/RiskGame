
import 'dart:convert';

import 'package:dio/src/response.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:risk/dataLayer/fileSystem.dart';

part 'user.g.dart';

@JsonSerializable()
class User{
  String username;
  String color;
  String email;
  String googleID;
  String id;
  
  int inGamePlayerNumber;

  User({this.username, this.color, this.googleID, this.id, this.email});

  void fromUser(User user){
    color = user.color;
    username = user.username;
        print("username: ${user.username}. current username: ${this.username}");
    email = user.email;
    id = user.id;
    googleID = user.googleID;
    encode(this);
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  void encode(User user) {
    writeContentToFileSystem("user.json", json.encode(this.toJson()));
  }

  static Future<User> decode() async {
    return User.fromJson(json.decode(await readContentFromFileSystem("user.json")));
  }

  void fromGoogleSignIn(GoogleSignInAccount account) {
    email = account.email;
    username = account.displayName;
    googleID = account.id;
    encode(this);
  }

  void fromRiskSignIn(Response signInResponse) {
    Map<String, dynamic> response = signInResponse.data as Map<String, dynamic>;
    this.id = response["id"];
    this.username = response["username"];
    this.color = response["faction"]["factionName"];
    this.googleID = response["connections"]["googleToken"];
    print("signed in from risk http call");
    encode(this);
  }
}