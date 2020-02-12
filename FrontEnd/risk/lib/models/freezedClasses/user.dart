import 'package:meta/meta.dart';

part 'user.freezed.dart';

@immutable
abstract class User with _$User {
  const factory User(String name, String message) = _User;
}