import 'package:flutter/material.dart';
import 'package:bang_music/pages/about.dart';
import 'package:bang_music/pages/library.dart';
import 'package:bang_music/pages/search.dart';

void main() => runApp(new BangMusic());

class BangMusic extends StatelessWidget {
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
              new DrawerHeader(
                child: new Text('Bang Music'),
              ),
              new ListTile(
                title: new Text('My Library'),
                onTap: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(builder: (context) => new MyLibrary())
                  );
                },
              ),
              new ListTile(
                title: new Text('Search'),
                onTap: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(builder: (context) => new SearchScreen())
                  );
                },
              ),
              new Divider(),
              new ListTile(
                title: new Text('About'),
                onTap: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(builder: (context) => new AboutScreen())
                  );
                },
              ),
            ],
          )
      ),
    );
  }
<<<<<<< HEAD
}

class MyLibrary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Library"),
      ),
      body: new Center(),
    );
  }
}

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Search"),
      ),
      body: new Center(),
    );
  }
}

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("About"),
      ),
      body: new Center(
        child: new Text(
          'Hello! This is the about page. Bang Music is an open source app.',
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: new TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
        ),
      ),
    );
  }
}