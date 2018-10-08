import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fz/pages/HomePage.dart';
import 'package:fz/style/FZColors.dart';
import 'package:redux/redux.dart';
import 'package:fz/redux/FZState.dart';
import 'package:fz/pages/WelcomePage.dart';
import 'package:fz/pages/LoginPage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fz/net/NetCode.dart';
import 'package:fz/style/FZString.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  final store = new Store<FZState>(appReducer, initialState: new FZState(
    feeds: new List(),
    nearbyModels: new List(),
    blogModels: new List(),
    photos: new List()
  ));


  MyApp({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return new StoreProvider(
        store: store,
        child: new StoreBuilder<FZState>(builder: (context, store) {
          return new MaterialApp(
            theme: store.state.themeData,
            routes: {
              WelcomePage.rName: (context) {
                return WelcomePage();
              },
              LoginPage.rName: (context) {
                return LoginPage();
              },
              HomePage.rName: (context) {
                return HomePage();
              }
            },
          );
        }));
  }

  errorHandleFunction(int code, message) {
    switch (code) {
      case NetCode.NETWORK_ERROR:
        Fluttertoast.showToast(msg: FZString.network_error);
        break;
      case NetCode.NETWORK_TIMEOUT:
        //超时
        Fluttertoast.showToast(msg: FZString.newwork_error_timeout);
        break;
      default:
        Fluttertoast.showToast(
            msg: FZString.network_error_unknow + " " + message);
        break;
    }
  }
}

//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {

//    return new MaterialApp(
//      title: "title",
////      home: new MyScaffold(),
////      home: new Demo(),
////      home: new Scaffold(
////        body: new AppTitle(),
////      ),
//
//
//      theme: new ThemeData(primaryColor: Colors.blue),
//    );

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
//  }
//}
