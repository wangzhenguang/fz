import 'package:flutter/material.dart';
import 'package:fz/net/NetEngine.dart';
import 'package:fz/net/service/UserService.dart';
import 'package:fz/util/LocalStorage.dart';

class MinePage extends StatelessWidget{

  @override
  StatelessElement createElement() {
    print("createElement");
    print(LocalStorage.remove(UserService.USER_INFO));

    return super.createElement();

  }


  @override
  Widget build(BuildContext context) {
    print("widget build(");

    return new Scaffold(
      appBar:AppBar(
        title: Text("我的"),
      ),
    );
  }



}