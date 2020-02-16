import 'package:flutter/cupertino.dart';
import 'package:risk/models/freezedClasses/user.dart';

class GlobalsProvider extends InheritedWidget{
  User user;

  GlobalsProvider({
    Key key,
    this.user,
    @required Widget child,
  }) : assert(child != null),
       super(key: key, child: child);

  static GlobalsProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<GlobalsProvider>();
  }

  @override
  bool updateShouldNotify(GlobalsProvider oldWidget) => oldWidget.user != this.user;
  
}