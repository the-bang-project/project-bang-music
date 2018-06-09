import 'package:flutter/material.dart';

enum CurrentTheme { dark, light }

final ThemeData darkTheme = new ThemeData(
    primaryColor: Colors.pink,
    backgroundColor: Colors.pink,
    buttonColor: Colors.pink,
    unselectedWidgetColor: Colors.white,
    brightness: Brightness.light,
    primaryTextTheme:
        new TextTheme(caption: new TextStyle(color: Colors.black)));

final ThemeData lightTheme = new ThemeData(
    primaryColor: Colors.pink,
    backgroundColor: Colors.pink,
    buttonColor: Colors.pink,
    unselectedWidgetColor: Colors.white,
    primaryTextTheme:
        new TextTheme(caption: new TextStyle(color: Colors.black)));
