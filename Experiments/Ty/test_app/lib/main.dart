import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var imageHeight = 500.0;

  var imageWidth = 100.0;

  void rescaleImageUp() {
    setState(() {
      if (imageHeight <= 800) {
        imageHeight += 50;
        imageWidth += 50;
        print('Up chosen');
      }
    });
    print('height = ' + imageHeight.toString());
  }

    void rescaleImageDown() {
    setState(() {
      if (imageHeight >= 0) {
        imageHeight -= 50;
        imageWidth -= 50;
        print('down chosen');
      }
    });
    print('height = ' + imageHeight.toString());
  }

  void resetImageScale() {
    setState(() {
      imageHeight = 500.0;
      imageWidth = 100.0;
    });
    print('height = ' + imageHeight.toString());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('asset image')),
        body: Image.asset(
          'assets/testMap.png',
          height: imageHeight,
          width: imageWidth,
        ),
        persistentFooterButtons: <Widget>[
          FlatButton(
            onPressed: rescaleImageUp,
            child: Text('+'),
          ),
          FlatButton(
            onPressed: rescaleImageDown,
            child: Text('-'),
          ),
        ],
      ),
    );
  }
}
