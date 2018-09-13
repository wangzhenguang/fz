import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fz/pages/LogPage.dart';
import 'package:fz/pages/MinePage.dart';
import 'package:fz/pages/NearbyPage.dart';
import 'package:fz/pages/PhotoPage.dart';
import 'package:fz/style/FZColors.dart';
import 'package:fz/widget/FZTabBarWidget.dart';
import 'package:fz/pages/DynamicPage.dart';

class HomePage extends StatelessWidget {
  static final String rName = "home";

  Future<bool> _dialogExitApp(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text("确认退出应用"),
              actions: <Widget>[
                new FlatButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text("取消")),
                new FlatButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text("确认"))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _dialogExitApp(context),
      child: FZTabBarWidget(
        type: FZTabBarWidget.BOTTOM_TAB,
        bottomNavigationBarItem: _renderBottomNavigateionItem(),
        tabViews: <Widget>[
          DynamicPage(),
          NearbyPage(),
          PhotoPage(),
          LogPage(),
          MinePage(),
        ],
        title: Text(
          "z",
          style: TextStyle(fontSize: 19.0, color: FZColors.whiteText),
        ),
      ),
    );
  }

  _renderBottomNavigateionItem() {
    return [
      BottomNavigationBarItem(
        icon: new Image.asset("static/images/icon_homepage_normal.png"),
        activeIcon: Image.asset("static/images/icon_homepage_selected.png"),
        title: Text("动态"),
      ),
      BottomNavigationBarItem(
        icon: new Image.asset("static/images/icon_homepage_normal.png"),
        activeIcon: Image.asset("static/images/icon_homepage_selected.png"),
        title: Text("附近"),
      ),
      BottomNavigationBarItem(
        icon: new Image.asset("static/images/icon_homepage_normal.png"),
        activeIcon: Image.asset("static/images/icon_homepage_selected.png"),
        title: Text("照片"),
      ),
      BottomNavigationBarItem(
        icon: new Image.asset("static/images/icon_homepage_normal.png"),
        activeIcon: Image.asset("static/images/icon_homepage_selected.png"),
        title: Text("日志"),
      ),
      BottomNavigationBarItem(
        icon: new Image.asset("static/images/icon_homepage_normal.png"),
        activeIcon: Image.asset("static/images/icon_homepage_selected.png"),
        title: Text("我的"),
      ),
    ];
  }
}
