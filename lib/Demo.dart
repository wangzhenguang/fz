import 'package:flutter/material.dart';

class Demo extends StatefulWidget {
//  @override
//  Widget build(BuildContext context) {
//
//    );
//  }

  @override
  State<StatefulWidget> createState() {
    return new DemoList();
  }
}

class DemoList extends State<Demo> {
  final _datas = <String>["布局示例", "购物车示例"];

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: '示例程序',
        theme: new ThemeData(primaryColor: Colors.blue),
        home: new Scaffold(
          body: new ListView(),
        ));
  }


}
