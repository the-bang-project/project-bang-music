import 'package:flutter/material.dart';
import 'package:bang_music/pages/player/player.dart';
import 'package:bang_music/utils/player/themes.dart';

void main() => runApp(new PlayerCaller());

class PlayerCaller extends StatefulWidget {
  @override
  MyMaterialAppState createState() {
    return new MyMaterialAppState();
  }
}

class MyMaterialAppState extends State<PlayerCaller> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false, theme: darkTheme, home: new Player());
  }
}
