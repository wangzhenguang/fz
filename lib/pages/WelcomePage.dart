import 'package:flutter/material.dart';
import 'package:fz/net/service/UserService.dart';
import 'package:fz/style/FZColors.dart';
import 'package:fz/redux/FZState.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fz/util/CommonUtils.dart';
import 'package:fz/util/LocalStorage.dart';
import 'package:fz/util/NavigatorUtils.dart';
import 'package:redux/redux.dart';
import 'dart:async';

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
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (isInit) return;
    isInit = true;

    Store<FZState> store = StoreProvider.of(context);
    print(store);
    CommonUtils.initStatusBarHeight(context);
    new Future.delayed(const Duration(seconds: 2), () {
      print(LocalStorage.get(UserService.USER_INFO));
      if (LocalStorage.get(UserService.USER_INFO) != null) {
        print(" 进入到主页");
        NavigatorUtils.goHome(context);
      } else {
        print(" 跳转到登录页面");
        NavigatorUtils.goLogin(context);
      }
    });
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
                "赞",
                style: new TextStyle(color: Colors.white, fontSize: 32.0),
              ),
            ));
      },
    );
  }
}
