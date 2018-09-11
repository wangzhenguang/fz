import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget titleSection = new Container(
      padding: const EdgeInsets.all(32.0),
      child: new Row(
        children: <Widget>[
          new Expanded(
              child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: new Text(
                  'Oeschinen Lake Campground',
                  style: new TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              new Text(
                'Kandersteg,Switzerland',
                style: new TextStyle(color: Colors.grey[100]),
              )
            ],
          )),
          new Icon(
            Icons.star,
            color: Colors.red[500],
          ),
          new Text("41")
        ],
      ),
    );

    Widget buttonSelection = new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          buildButtonClumn(Icons.call, "CALL", context),
          buildButtonClumn(Icons.near_me, "ROUTE", context),
          buildButtonClumn(Icons.share, "SHARE", context)
        ],
      ),
    );

    Widget textSection = new Container(
      padding: const EdgeInsets.all(32.0),
      child: new Text(
        '''
Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. A gondola ride from Kandersteg, followed by a half-hour walk through pastures and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. Activities enjoyed here include rowing, and riding the summer toboggan run.
        ''',
        softWrap: true,
      ),
    );

    return new ListView(
      children: <Widget>[
        new Image.asset(
          "images/bg.jpg",
          height: 240.0,
          fit: BoxFit.cover,
        ),
        titleSection,
        buttonSelection,
        textSection
      ],
    );
  }

  Column buildButtonClumn(IconData icon, String label, BuildContext context) {
    Color color = Theme.of(context).primaryColor;

    return new Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Icon(
          icon,
          color: color,
        ),
        new Container(
          margin: const EdgeInsets.only(top: 8.0),
          child: new Text(
            label,
            style: new TextStyle(
                fontSize: 12.0, fontWeight: FontWeight.w400, color: color),
          ),
        )
      ],
    );
  }
}
