import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fz/net/NetEngine.dart';
import 'package:fz/net/service/Api.dart';
import 'package:fz/style/FZColors.dart';
import 'package:fz/util/LocalStorage.dart';
import 'package:fz/util/NavigatorUtils.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("设置"),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              constraints: BoxConstraints(minWidth: double.infinity),
              child: FlatButton(
                child: Text(
                  '退出登录',
                  style: Theme.of(context).textTheme.button,
                ),
                color: Theme.of(context).buttonColor,
                onPressed: () {
                  LocalStorage.remove(Api.USER_TOKEN).then((e) {
                    NetEngine.removeToken();
                    while (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                    NavigatorUtils.goLogin(context);
                  });
                },
              ),
              margin: EdgeInsets.all(10.0),
            ),
          ],
        ));
  }
}
