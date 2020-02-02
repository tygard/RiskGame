import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gradient_text/gradient_text.dart';

class LoadScreen extends StatefulWidget {
  @override
  _LoadScreenState createState() => _LoadScreenState();
}

class _LoadScreenState extends State<LoadScreen> {
  @override
  void initState() {
    _loadApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Center(
            child: GradientText(
          "RISK",
          gradient: LinearGradient(
              colors: [Color(0xFFFFC152), Color(0xFFe57a00)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 56, fontFamily: 'Digital'),
        )),
      ),
    );
  }

  void _loadApp() async {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 3)).then((_){
        Navigator.of(context).pushReplacementNamed("/login");
        }
        );
    });
  }
}
