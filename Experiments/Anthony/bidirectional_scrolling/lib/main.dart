import 'package:bidirectional_scrolling/grid.dart';
import 'package:flutter/material.dart';
import 'package:diagonal_scrollview/diagonal_scrollview.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(backgroundColor: Colors.white),
          home: Scaffold(
                      body: SafeArea(
        child: DiagonalScrollView(
            child: Grid(
              dimension: 40,
            ),
        ),
      ),
          ),
    );
  }
}
