import 'package:flutter/material.dart';
import 'package:hello_flutter/MyAppBar.dart';

class MyScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Column(
        children: <Widget>[
          new AppBar(
            title: new Text(
              'Appbar title',
              style: Theme.of(context).primaryTextTheme.title,
            ),
            actions: <Widget>[
              new IconButton(icon: new Icon(Icons.menu), onPressed: null)
            ],
          ),
          new Expanded(
              child: new Center(
            child: new Text("hello world"),
          ))
        ],
      ),
    );
  }
}
