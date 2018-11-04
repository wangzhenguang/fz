import 'package:flutter/material.dart';
import 'package:fz/net/NetEngine.dart';
import 'package:fz/net/service/Api.dart';
import 'package:fz/style/FZColors.dart';
import 'package:fz/redux/FZState.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fz/util/CommonUtils.dart';
import 'package:fz/util/LocalStorage.dart';
import 'package:fz/util/NavigatorUtils.dart';
import 'package:redux/redux.dart';
import 'dart:async';
import 'dart:convert';

class WelcomePage extends StatefulWidget {
  static final String rName = "/";

  @override
  State<StatefulWidget> createState() {
    return new WelcomePageState();
  }
}

class WelcomePageState extends State<WelcomePage> {
  bool isInit = false;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (isInit) return;
    isInit = true;
    Store<FZState> store = StoreProvider.of(context);
    CommonUtils.initStatusBarHeight(context);
    var userinfo = await getUserInfo();
    new Future.delayed(const Duration(seconds: 2), () {
      if (userinfo != null) {
        NavigatorUtils.goHome(context);
      } else {
        print(" 跳转到登录页面");
        NavigatorUtils.goLogin(context);
      }
    });
  }

  getUserInfo() async {
    var userInfo = await LocalStorage.get(Api.USER_INFO);

    return userInfo;
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<FZState>(
      builder: (context, store) {
        return new Scaffold(
            backgroundColor: Color(FZColors.primaryValue),
            body: new Container(
              padding: EdgeInsets.only(top: 200.0),
              alignment: Alignment.topCenter,
              child: new Text(
                "飞赞",
                style: new TextStyle(color: Colors.white, fontSize: 32.0),
              ),
            ));
      },
    );
  }
}
