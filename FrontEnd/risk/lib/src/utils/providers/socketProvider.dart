import 'package:flutter/cupertino.dart';
import 'package:risk/src/utils/socketManager.dart';

class SocketProvider extends InheritedWidget {
    const SocketProvider({
    Key key,
    @required this.socketManager,
    @required Widget child,
  }) : assert(child != null),
       super(key: key, child: child);

  final SocketManager socketManager;


  static SocketProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SocketProvider>();
  }

  @override
  bool updateShouldNotify(SocketProvider old) => false;
}