import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Toaster{
  static void errorToast(String message){
    _toast(message, Color(0xFFff6961),  Color(0xFF8b0000));
  }

  static void successToast(String message){
    _toast(message, Color(0xFF90ee90), Colors.green);
  }

  static void warningToast(String message){
    _toast(message, Color(0xFFffdb58),  Color(0xFFc49102));
  }

  static void helpToast(String message){
    _toast(message, Color(0xFF80cee1), Color(0xFF274e88));
  }

  static void _toast(String message, Color bgColor, Color textColor){
       Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        backgroundColor: bgColor,
        textColor: textColor,
        fontSize: 16.0
    );
  }
}