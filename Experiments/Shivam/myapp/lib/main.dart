import 'package:flutter/material.dart';

void main() {
  // debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  bool pressed = true;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Button Presser"),
        ),
        body: Center(
          child: FlatButton(
            onPressed: () => setState(() => pressed = !pressed),
            child: Text('Click me'),
            color: pressed ? Colors.red : Colors.blue
          )
        )
      ),
    );
  }
}
