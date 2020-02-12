import 'package:risk/src/freezedClasses/chat.dart';

Stream<Chat> listenToChatGlobal() async* {
  yield Chat('Anthony', "Hello");
  await Future.delayed(Duration(seconds: 3));
  yield Chat('Luigi', "Hello retard");
  await Future.delayed(Duration(seconds: 3));
  yield Chat('Alexis', "Stop being mean bro");
  await Future.delayed(Duration(seconds: 3));
  yield Chat('Alex', "I like the big ronas");
  await Future.delayed(Duration(seconds: 3));
  yield Chat('Pierce', "Hello");
  await Future.delayed(Duration(seconds: 3));
}