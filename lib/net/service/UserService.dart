import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fz/net/NetCode.dart';
import 'package:fz/net/NetEngine.dart';
import 'package:fz/net/ResultData.dart';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';

import 'package:fz/util/LocalStorage.dart';

class UserService {
  static const loginUrl =
      "http://api.feizan.com/api.php?a=login&m=account/account";
  static const USER_INFO = "user_info";

  static login(userName, password) async {
    var content = new Utf8Encoder().convert(password);
    var digest = md5.convert(content);
    var authorization = hex.encode(digest.bytes);

    var params = new FormData.from(
        {"authorization": authorization, "username": userName});
    ResultData res = await NetEngine.excute(loginUrl, params);
    if (res != null && res.code == NetCode.SUCCESS) {
      var data = res.data;
      print("login result $data");
      NetEngine.saveToken(data['auth_token']);
      // 保存用户数据
      await LocalStorage.save(USER_INFO, data);
      return res.data;
    }
  }
}
