// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

abstract class _$User {
  String get name;
  String get message;

  User copyWith({String name, String message});
}

class _$_User implements _User {
  const _$_User(this.name, this.message);

  @override
  final String name;
  @override
  final String message;

  @override
  String toString() {
    return 'User(name: $name, message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return other is _User &&
        (identical(other.name, name) || other.name == name) &&
        (identical(other.message, message) || other.message == message);
  }

  @override
  int get hashCode => runtimeType.hashCode ^ name.hashCode ^ message.hashCode;

  @override
  _$_User copyWith({
    Object name = immutable,
    Object message = immutable,
  }) {
    return _$_User(
      name == immutable ? this.name : name as String,
      message == immutable ? this.message : message as String,
    );
  }
}

abstract class _User implements User {
  const factory _User(String name, String message) = _$_User;

  @override
  String get name;
  @override
  String get message;

  @override
  _User copyWith({String name, String message});
}
