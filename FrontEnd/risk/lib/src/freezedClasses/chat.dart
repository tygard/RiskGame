import 'package:meta/meta.dart';

part 'chat.freezed.dart';

@immutable
abstract class Chat with _$Chat {
  const factory Chat(String name, String message) = _Chat;
}