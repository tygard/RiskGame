import 'package:flutter/material.dart';

class Biscroller extends StatelessWidget {
  final Widget child;

  Biscroller({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: child,);
  }
}