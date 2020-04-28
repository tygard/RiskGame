//playerNum corresponds to the INDEX of the player num.
import 'package:flutter/material.dart';
import 'package:risk/models/gameStateObjects/game.dart';
import 'package:risk/src/utils/serviceProviders.dart';

String mapPlayerNumToColorName(int playerNum) {
  assert(playerNum >= -2 && playerNum <= 4);
  switch (playerNum) {
    case -2:
      return "black";
    case -1:
      return "grey";
    case 0:
      return "red";
    case 1:
      return "blue";
    case 2:
      return "green";
    case 3:
      return "yellow";
  }
    throw Exception("how the fuck dude");
}

Color mapPlayerNumToColor(int playerNum) {
  assert(playerNum >= -2 && playerNum <= 4);
  switch (playerNum) {
    case -2:
      return Colors.black;
    case -1:
      return Colors.grey;
    case 0:
      return Colors.red;
    case 1:
      return Colors.blue;
    case 2:
      return Colors.green;
    case 3:
      return Colors.yellow;
  }
  throw Exception("how the fuck dude");
}

//takes a turn ID and returns an index, to use with the previous functions.
//ex if the playerID is 12, you can do Color color = mapPlayerNumToColor(getPlayerIndex(12));
int getPlayerIndex(int playerID){
  if (playerID < 0) return -1;
  List<InGameUser> users = locator<GameState>().users;
  for (int i = 0; i < users.length; i++){
    if (users[i].turnID == playerID){
      return i;
    }
  }
  throw Exception("player $playerID not in game.");
}

bool adjacentOffset(Offset one, Offset two){
  if (!(one.dx == two.dx || one.dx + 1 == two.dx || one.dx - 1 == two.dx)){
    return false;
  }
    if (!(one.dy == two.dy || one.dy + 1 == two.dy || one.dy - 1 == two.dy)){
    return false;
  }
  return true;
}


