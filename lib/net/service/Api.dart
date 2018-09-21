import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fz/config/Config.dart';
import 'package:fz/model/FeedsModel.dart';
import 'package:fz/model/photo/PhotoModel.dart';
import 'package:fz/net/NetCode.dart';
import 'package:fz/net/NetEngine.dart';
import 'package:fz/net/ResultData.dart';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:fz/redux/FeedsRedux.dart';
import 'package:fz/redux/PhotoRedux.dart';

import 'package:fz/util/LocalStorage.dart';
import 'package:fz/util/NavigatorUtils.dart';
import 'package:redux/redux.dart';

abstract class Api {
  static const baseUrl = "http://api.feizan.com/api.php";

  static const loginUrl =
      "http://api.feizan.com/api.php?a=login&m=account/account";
  static const userProfile = "$baseUrl?m=user/user&a=getProfile&uid=";
  static const feedsUrl =
      "$baseUrl?m=feed/feed&a=getFeeds&scope=all&pageSize=${Config.DYNAMIC_PAGE_SIZE}&page=";

  static const USER_INFO = "user_info";
  static const USER_TOKEN = "user_token";

  static login(userName, password) async {
    var content = new Utf8Encoder().convert(password);
    var digest = md5.convert(content);
    var authorization = hex.encode(digest.bytes);

    var params = new FormData.from(
        {"authorization": authorization, "username": userName});
    ResultData res = await NetEngine.excute(loginUrl, params, method: "post");
    if (res != null && res.code == NetCode.SUCCESS) {
      if (res.data["account_status"] == 1) {
        print("${res.data}");
        NetEngine.saveToken(res.data['auth_token']);
        // 保存用户数据
        await LocalStorage.save(USER_INFO, res.data["data"].toString());
        await LocalStorage.save(USER_TOKEN, res.data['auth_token']);
      }

      return res.data;
    }
  }

  static Future<BaseModel> getFeeds(Store store, page) async {
    ResultData res = await NetEngine.excute("$feedsUrl$page", null);
    if (res != null && res.code == NetCode.SUCCESS) {
      BaseModel baseModel = new BaseModel.fromJson(res.data);
      print('getFeeds $baseModel.');
      //判断是否获取数据成功
      if (res.data["feed_status"] == 1 && page == 1) {
        store.dispatch(new FeedsRefreshAction(baseModel.data.list));
      } else if (res.data["feed_status"] == 1 && page > 1) {
        store.dispatch(new FeedsLoadMoreAction(baseModel.data.list));
      }
      return baseModel;
    }
    return null;
  }

  static Future<PhotoModel> getAllPhotos(Store store, page) async {
    var allPhotos =
        "$baseUrl?m=user/photo&a=getAllPhotos&pageSize=${Config.PHOTO_PAGE_SIZE}&type=hot&page=$page";

    ResultData res = await NetEngine.excute(allPhotos, null);
    if (res != null && res.code == NetCode.SUCCESS) {
      PhotoModel baseModel = new PhotoModel.fromJson(res.data);
      print('getAllPhotos $baseModel.');
      //判断是否获取数据成功
      if (res.data["photo_status"] == 1 && page == 1) {
        store.dispatch(new RefreshEventAction(baseModel.data.list));
      } else if (res.data["photo_status"] == 1 && page > 1) {
        store.dispatch(new LoadMoreEventAction(baseModel.data.list));
      }
      return baseModel;
    }
    return null;
  }

  static void updateLocation(latitude, longitude) {
    String updateLocationUrl =
        "$baseUrl?m=user/user&a=updateLocation&pageSize=32&latitude=$latitude&longitude=$longitude";
  }

  static getNearUsers(latitude, longitude) {
    String url =
        "$baseUrl?m=search/friend&a=getNearUsers&pageSize=32&latitude=$latitude&longitude=$longitude";
  }

  static getHotBlogs(page, {period = 30}) {
    String url =
        "$baseUrl?m=user/blog&a=getHotBlog&pageSize=${Config.DYNAMIC_PAGE_SIZE}&period=$period&page=$page";
  }

  static getUserProfile(uid) {
    String url = "$baseUrl?m=user/user&a=getProfile&uid=$uid";
  }
}
