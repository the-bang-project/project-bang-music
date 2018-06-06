import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Bang Music',
      theme: new ThemeData(
        primaryColor: Colors.pink,
        backgroundColor: Colors.pink,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.black),
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Homepage'),
      ),
      drawer: new Drawer(
          child: new ListView(
            children: <Widget> [
              new DrawerHeader(child: new Text('Bang Music'),),
              new ListTile(
                title: new Text('My Library'),
                onTap: () {},
              ),
              new ListTile(
                title: new Text('Search'),
                onTap: () {},
              ),
              new Divider(),
              new ListTile(
                title: new Text('About'),
                onTap: () {},
              ),
            ],
          )
      ),
    );
  }
}