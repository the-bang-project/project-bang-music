import 'package:flutter/material.dart';
import 'package:bang_music/pages/player.dart';
import 'package:bang_music/utils/themes.dart';

void main() => runApp(new MyMaterialApp());

class MyMaterialApp extends StatefulWidget {
  @override
  MyMaterialAppState createState() {
    return new MyMaterialAppState();
  }
}

class MyMaterialAppState extends State<MyMaterialApp> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false, theme: darkTheme, home: new Player());
  }
}
