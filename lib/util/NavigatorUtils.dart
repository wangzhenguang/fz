import 'package:flutter/material.dart';
import 'package:fz/pages/FeedsDetailPage.dart';
import 'package:fz/pages/HomePage.dart';
import 'package:fz/pages/LoginPage.dart';
import 'package:fz/pages/Register.dart';

class NavigatorUtils {
  ///登录页
  static goLogin(BuildContext context) {
    Navigator.pushReplacementNamed(context, LoginPage.rName);
  }

  ///首页
  static goHome(BuildContext context) {
    Navigator.pushReplacementNamed(context, HomePage.rName);
  }

  //注册页面
  static goRegister(BuildContext context) {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new RegisterPage();
    }));
  }

  static goFeedsDetail(BuildContext context, String id, String idType) {
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (context) => FeedsDetailPage(id, idType)));
  }
}
