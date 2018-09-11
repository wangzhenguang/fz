import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  final Widget title;

  MyAppBar({this.title});

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 56.0,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: new BoxDecoration(color: Colors.blue[500]),
      child: new Row(
        children: <Widget>[
          new IconButton(
              icon: new Icon(Icons.menu),
              tooltip: "Navigation menu",
              onPressed: null),
          new Expanded(
            child: new Center(
              child: title,
            ),
          ),
          new IconButton(
              icon: new Icon(Icons.search), tooltip: "Search", onPressed: null)
        ],
      ),
    );
  }
}
