import 'package:flutter/material.dart';
import 'package:hello_flutter/pages/MainPage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "title",
      home: new MainPage(),
//      home: new MyScaffold(),
//      home: new Demo(),
//      home: new Scaffold(
//        body: new AppTitle(),
//      ),
      theme: new ThemeData(primaryColor: Colors.blue),
    );

//    return new MaterialApp(
//      title: 'Flutter Demo',
//      theme: new ThemeData(primarySwatch: Colors.blue),
//      home: new Scaffold(
//        body: new AppTitle(),
//      ),
//    );
//    return new MaterialApp(
//      title: 'Welcome to Flutter',
//      home: new Scaffold(
//        appBar: new AppBar(
//          title: new Text('Welcome to Flutter'),
//        ),
//        body: new Center(
////          child: new Text(wordPair.asPascalCase),
//          child: new RandomWords(),
//        ),
//      ),
//    );
  }
}
