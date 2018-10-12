import 'package:flutter/material.dart';
import 'package:fz/model/feeds/FeedsModel.dart';
import 'package:fz/model/photo/PhotoViewModule.dart';
import 'package:fz/pages/FeedsDetailPage.dart';
import 'package:fz/pages/HomePage.dart';
import 'package:fz/pages/LoginPage.dart';
import 'package:fz/pages/OtherDetailInfoPage.dart';
import 'package:fz/pages/Register.dart';
import 'package:fz/pages/photo/PhotoViewPage.dart';
import 'package:fz/pages/setting/SettingPage.dart';

class NavigatorUtils {
  ///登录页
  static goLogin(BuildContext context) {
    Navigator.pushReplacementNamed(context, LoginPage.rName);
  }

  static goUntilLoginPage(BuildContext context){
    while(Navigator.canPop(context)){
      Navigator.pop(context);
    }
    goLogin(context);
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

  static goFeedsDetail(BuildContext context, FeedsModel feedmodel) {
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (context) => FeedsDetailPage(feedmodel)));
  }

  static goPhotoViewPage(BuildContext context, PhotoViewModule module) {
    Navigator.of(context).push(
        new MaterialPageRoute(builder: (context) => PhotoViewPage(module)));
  }

  static void goSetting(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SettingPage()));
  }

  static void goOtherDetail(BuildContext context, String username, String uid) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => OtherDetailInfoPage(username, uid)));
  }
}
