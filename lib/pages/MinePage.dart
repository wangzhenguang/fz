import 'package:flutter/material.dart';
import 'package:fz/model/user/UserInfo.dart';
import 'package:fz/net/service/Api.dart';
import 'package:fz/style/FZColors.dart';
import 'package:fz/util/LocalStorage.dart';
import 'package:fz/widget/FZUserIcon.dart';
import 'dart:convert';

class MinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage>
    with AutomaticKeepAliveClientMixin, WidgetsBindingObserver {
  var titles = ["访客", "相册", "日志", "动态", "设置"];
  UserInfo _userInfo;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    print('build');
    var list = ListView.builder(
        itemCount: titles.length * 2 + 2,
        itemBuilder: (context, index) => _renderRow(index));

    return list;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getUserProfile();
  }

  _getUserProfile() {
    LocalStorage.get(Api.USER_INFO).then((value) {
      setState(() {
        this._userInfo = UserInfo.fromJson(json.decode(value)["data"]);
        print("${_userInfo.toString()}");
      });
    });
//    Api.getUserProfile(userName, userPass).then((res) {
//      Navigator.pop(context);
//      if (res != null && res["account_status"] == 1) {
//        NavigatorUtils.goHome(context);
//      } else if (res != null && res["account_status"] == 0) {
//        Fluttertoast.showToast(msg: "账号密码有误！", gravity: ToastGravity.CENTER);
//      }
//    });
  }

  _renderRow(int index) {
    if (index == 0) {
      var header = new Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: FZUserIcon(image: _userInfo.avatar),
          ),
          Expanded(
            child: Text(
              _userInfo.username,
              style: TextStyle(color: Colors.white),
            ),
          ),
          Icon(Icons.settings)
        ],
      );

      var widget = new Column(
        children: <Widget>[
          header,
          new Container(
            margin: EdgeInsets.only(top: 20.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Text("记录"),
                      Text(_userInfo == null ? "0" : _userInfo?.note)
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Text("关注"),
                      Text(_userInfo == null ? "0" : _userInfo?.follows_count)
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Text("粉丝"),
                      Text(_userInfo == null ? "0" : _userInfo.fans_count)
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      );

      return widget;
    } else if (index == 1) {
      return Container(
        height: 5.0,
        margin: EdgeInsets.only(top: 10.0),
        color: Color(FZColors.cellBlackBg),
      );
    }
    index -= 2;
    // 去掉上面的头部 和 分割线
    if (index.isOdd) {
      //偶数 为分割线
      return Divider(
        height: 1.0,
        color: Colors.white,
        indent: 10.0,
      );
    }

    index = index ~/ 2;
    String title = titles[index];
    var row = new Row(children: <Widget>[
      new Expanded(
          child: new Text(
        title,
      )),
    ]);

    ///    if(index != titles.length-1){
    row.children.add(Icon(
      Icons.keyboard_arrow_right,
      color: Color(FZColors.textGray),
    ));
    var listItemContent = new Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0), child: row);

    return InkWell(
      onTap: () {
        switch (index) {
          case 0:
            print("访客");
            break;
          case 1:
            print("相册");
            break;
          case 2:
            print("日志");
            break;
          case 3:
            print("动态");
            break;
          case 4:
            print("设置");
            break;
        }
      },
      child: listItemContent,
    );
  }
}
