import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
void main() => runApp(MapGridTest());

class MapGridTest extends StatefulWidget {
  @override
  _MapGridTestState createState() => _MapGridTestState();
}

class _MapGridTestState extends State<MapGridTest> {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: CustomScrollView(
          slivers: <Widget>[
            Container(
              color: Colors.orange,
            )
          ],
        ),
      ),
    );
  }
}
