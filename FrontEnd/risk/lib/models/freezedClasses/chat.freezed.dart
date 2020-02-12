// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

abstract class _$Chat {
  String get name;
  String get message;

  Chat copyWith({String name, String message});
}

class _$_Chat implements _Chat {
  const _$_Chat(this.name, this.message);

  @override
  final String name;
  @override
  final String message;

  @override
  String toString() {
    return 'Chat(name: $name, message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return other is _Chat &&
        (identical(other.name, name) || other.name == name) &&
        (identical(other.message, message) || other.message == message);
  }

  @override
  int get hashCode => runtimeType.hashCode ^ name.hashCode ^ message.hashCode;

  @override
  _$_Chat copyWith({
    Object name = immutable,
    Object message = immutable,
  }) {
    return _$_Chat(
      name == immutable ? this.name : name as String,
      message == immutable ? this.message : message as String,
    );
  }
}

abstract class _Chat implements Chat {
  const factory _Chat(String name, String message) = _$_Chat;

  @override
  String get name;
  @override
  String get message;

  @override
  _Chat copyWith({String name, String message});
}
