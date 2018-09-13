import 'package:flutter/material.dart';
import 'package:fz/net/service/UserService.dart';
import 'package:fz/pages/Register.dart';
import 'package:fz/style/FZColors.dart';
import 'package:fz/util/CommonUtils.dart';
import 'package:fz/util/NavigatorUtils.dart';

class LoginPage extends StatefulWidget {
  static final String rName = "login";

  @override
  State<StatefulWidget> createState() {
    return new LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  var leftRightPadding = 30.0;
  var topBottomPadding = 4.0;
  var textTips = new TextStyle(fontSize: 16.0, color: Colors.black);
  var hintTips = new TextStyle(fontSize: 15.0, color: Colors.black26);
  static const LOGO = "static/images/bg.jpg";

  var _userPassController = new TextEditingController();
  var _userNameController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "登录",
          style: new TextStyle(color: Colors.white),
        ),
        iconTheme: new IconThemeData(color: Colors.black),
      ),
      body: new Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Padding(
              padding: new EdgeInsets.fromLTRB(
                  leftRightPadding, 50.0, leftRightPadding, 10.0),
              child: new Image.asset(
                LOGO,
                width: 100.0,
                height: 100.0,
              )),
          new Padding(
            padding: new EdgeInsets.fromLTRB(
                leftRightPadding, 50.0, leftRightPadding, topBottomPadding),
            child: new TextField(
              style: textTips,
              controller: _userNameController,
              decoration: new InputDecoration(hintText: "请输入用户名"),
            ),
          ),
          new Padding(
            padding: new EdgeInsets.fromLTRB(
                leftRightPadding, 30.0, leftRightPadding, topBottomPadding),
            child: new TextField(
              style: textTips,
              controller: _userPassController,
              decoration: new InputDecoration(hintText: "请输入密码"),
              obscureText: true,
            ),
          ),
          new Container(
            padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
            child: new Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Expanded(
                  child: new Card(
                    color: Color(FZColors.primaryValue),
                    child: new FlatButton(
                        onPressed: _login,
                        child: new Text("登录",
                            style: new TextStyle(color: Colors.white))),
                  ),
                ),
                new Expanded(
                  child: new Card(
                    color: Color(FZColors.primaryValue),
                    child: new FlatButton(
                        onPressed: () => NavigatorUtils.goRegister(context),
                        child: new Text("注册",
                            style: new TextStyle(color: Colors.white))),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _login() {
    var userPass = _userPassController.text;
    var userName = _userNameController.text;
    CommonUtils.showLoadingDialog(context);
    UserService.login(userName, userPass).then((res) {
      Navigator.pop(context);
      if (res != null) {
        print('gohome');
        NavigatorUtils.goHome(context);
      }
    });
//    NavigatorUtils.goHome(context);
  }
}
