import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fz/pages/LogPage.dart';
import 'package:fz/pages/MinePage.dart';
import 'package:fz/pages/NearbyPage.dart';
import 'package:fz/pages/PhotoPage.dart';
import 'package:fz/style/FZColors.dart';
import 'package:fz/style/FZIconfont.dart';
import 'package:fz/style/FZTextStyle.dart';
import 'package:fz/widget/BottomNavigationWidget.dart';
import 'package:fz/widget/FZTabBarWidget.dart';
import 'package:fz/pages/DynamicPage.dart';

class HomePage extends StatefulWidget {
  static final String rName = "home";

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  final tabTitle = ["动态", "附近", "照片", "日志", "我的"];

  final tabTextStyleNormal =
      new TextStyle(color: const Color(FZColors.textGray));
  final tabTextStyleSelected = new TextStyle(color: Color(FZColors.textGray));
  String _title;

  int _tabIndex = 0;

  Future<bool> _dialogExitApp(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text("确认退出应用"),
              actions: <Widget>[
                new FlatButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text(
                      "取消",
                      style: FZTextStyle.normalText,
                    )),
                new FlatButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text(
                      "确认",
                      style: FZTextStyle.normalText,
                    ))
              ],
            ));
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _title = tabTitle[_tabIndex];
    });
  }

  List<Widget> _list = <Widget>[
    DynamicPage(),
    NearbyPage(),
    PhotoPage(),
    LogPage(),
    MinePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _dialogExitApp(context),
      child: FZTabBarWidget(
        type: FZTabBarWidget.BOTTOM_TAB,
        bottomNavigationBarItem: _renderBottomNavigateionItem(),
        tabViews: _list,
        title: _renderAppBar(),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.add_a_photo), onPressed: _takePhoto),
          new IconButton(icon: new Icon(Icons.note_add), onPressed: _writeNote)
        ],
        onPageChanged: _onPageChanged,
      ),
    );

    return WillPopScope(
      onWillPop: () => _dialogExitApp(context),
      child: BottomNavigationWidget(
        tabBarTitles: tabTitle,
        tabImages: _tabImages,
        body: _body,
        titles: tabTitle,
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.add_a_photo), onPressed: _writeNote),
          new IconButton(icon: new Icon(Icons.note_add), onPressed: _writeNote)
        ],
        tabTextNormal: Color(FZColors.primaryDarkValue),
        tabTextSelected: Color(FZColors.colorPri),
        themeColor: Color(FZColors.colorPri),
      ),
    );
  }

  _onPageChanged(index) {
    print("_onPageChanged $index");
    setState(() {
      _title = tabTitle[index];
      this._tabIndex = index;
    });
  }

  _writeNote() {
    Fluttertoast.showToast(msg: "暂未开发此功能");
  }

  _takePhoto() {
    Fluttertoast.showToast(msg: "暂未开发此功能");
  }

  _renderAppBar() {
    return Text(_title,
        style: TextStyle(fontSize: 19.0, color: FZColors.whiteText));
  }

  var _tabImages = [
    [
      Icon(
        FZIconFont.dynamic,
        color: Color(FZColors.primaryDarkValue),
      ),
      Icon(
        FZIconFont.dynamic,
        color: Color(FZColors.colorPri),
      )
    ],
    [
      Icon(
        FZIconFont.nearby,
        color: Color(FZColors.primaryDarkValue),
      ),
      Icon(
        FZIconFont.nearby,
        color: Color(FZColors.colorPri),
      )
    ],
    [
      Icon(
        FZIconFont.photo,
        color: Color(FZColors.primaryDarkValue),
      ),
      Icon(
        FZIconFont.photo,
        color: Color(FZColors.colorPri),
      )
    ],
    [
      Icon(
        FZIconFont.log,
        color: Color(FZColors.primaryDarkValue),
      ),
      Icon(
        FZIconFont.log,
        color: Color(FZColors.colorPri),
      )
    ],
    [
      Icon(
        FZIconFont.mine,
        color: Color(FZColors.primaryDarkValue),
      ),
      Icon(
        FZIconFont.mine,
        color: Color(FZColors.colorPri),
      )
    ]
  ];

  var _body = <Widget>[
    DynamicPage(),
    NearbyPage(),
    PhotoPage(),
    LogPage(),
    MinePage(),
  ];

  _renderBottomNavigateionItem() {
    return [
      BottomNavigationBarItem(
        icon: Icon(
          FZIconFont.dynamic,
          color: Color(FZColors.textGray),
        ),
        activeIcon: Icon(
          FZIconFont.dynamic,
          color: Color(FZColors.textGray),
        ),
        title: getTabTitle(0),
      ),
      BottomNavigationBarItem(
        icon: Icon(
          FZIconFont.nearby,
          color: Color(FZColors.textGray),
        ),
        activeIcon: Icon(
          FZIconFont.nearby,
          color: Color(FZColors.textGray),
        ),
        title: getTabTitle(1),
      ),
      BottomNavigationBarItem(
        icon: Icon(
          FZIconFont.photo,
          color: Color(FZColors.textGray),
        ),
        activeIcon: Icon(
          FZIconFont.photo,
          color: Color(FZColors.textGray),
        ),
        title: getTabTitle(2),
      ),
      BottomNavigationBarItem(
        icon: Icon(
          FZIconFont.log,
          color: Color(FZColors.textGray),
        ),
        activeIcon: Icon(
          FZIconFont.log,
          color: Color(FZColors.textGray),
        ),
        title: getTabTitle(3),
      ),
      BottomNavigationBarItem(
        icon: Icon(
          FZIconFont.mine,
          color: Color(FZColors.textGray),
        ),
        activeIcon: Icon(
          FZIconFont.mine,
          color: Color(FZColors.textGray),
        ),
        title: getTabTitle(4),
      ),
    ];
  }

  Text getTabTitle(int curIndex) {
    return new Text(tabTitle[curIndex], style: getTabTextStyle(curIndex));
  }

  TextStyle getTabTextStyle(int curIndex) {
    if (curIndex == _tabIndex) {
      return tabTextStyleSelected;
    }
    return tabTextStyleNormal;
  }

  @override
  bool get wantKeepAlive => true;
}
