import 'package:intl/intl.dart';

class Chat {
  String name;
  String message;
  String whenSent;

  Chat(this.name, this.message, this.whenSent);

  factory Chat.fromJson(Map<String, dynamic> json){
    return Chat(json["username"], json["message"], DateFormat('EEE, h:mm a').format(DateTime.now()));
  }
}