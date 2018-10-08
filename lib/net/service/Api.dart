import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fz/config/Config.dart';
import 'package:fz/model/FeedsModel.dart';
import 'package:fz/model/nearby/NearbyModel.dart';
import 'package:fz/model/photo/PhotoModel.dart';
import 'package:fz/net/NetCode.dart';
import 'package:fz/net/NetEngine.dart';
import 'package:fz/net/ResultData.dart';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:fz/redux/FeedsRedux.dart';
import 'package:fz/redux/LogRedux.dart';
import 'package:fz/redux/NearbyRedux.dart';
import 'package:fz/redux/PhotoRedux.dart';

import 'package:fz/util/LocalStorage.dart';
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
        await LocalStorage.save(USER_INFO, json.encode(res.data["data"]));
        await LocalStorage.save(USER_TOKEN, res.data['auth_token']);
      }

      return res.data;
    }
  }

  static Future<BaseModel> getFeeds(Store store, page) async {
    ResultData res = await NetEngine.excute("$feedsUrl$page", null);
    if (res != null && res.code == NetCode.SUCCESS) {
      BaseModel baseModel = new BaseModel.fromJson(res.data);
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

  static void updateLocation(latitude, longitude) async {
    String updateLocationUrl =
        "$baseUrl?m=user/user&a=updateLocation&pageSize=32&latitude=$latitude&longitude=$longitude";
    NetEngine.excute(updateLocationUrl, null);
  }

  static getNearUsers(store, latitude, longitude, int page) async {
    String url =
        "$baseUrl?m=search/friend&a=getNearUsers&pageSize=32&latitude=$latitude&longitude=$longitude&page=$page";
    ResultData res = await NetEngine.excute(url, null);
    if (res != null && res.code == NetCode.SUCCESS) {
      NearbyModel baseModel = new NearbyModel.fromJson(res.data);
      //判断是否获取数据成功
      if (baseModel.search_status == 1 && page == 1) {
        store.dispatch(new NearbyRefreshAction(baseModel.data.user));
      } else if (res.data["search_status"] == 1 && page > 1) {
        store.dispatch(new NearbyLoadMoreAction(baseModel.data.user));
      }
      return baseModel;
    }
  }

  static getHotBlogs(store, int page, {period = 30}) async {
    String url =
        "$baseUrl?m=user/blog&a=getHotBlogs&pageSize=${Config.DYNAMIC_PAGE_SIZE}&period=$period&page=$page";

    ResultData res = await NetEngine.excute(url, null);
    if (res != null && res.code == NetCode.SUCCESS) {
      BaseModel baseModel = new BaseModel.fromJson(res.data);
      //判断是否获取数据成功
      if (baseModel.status == 1 && page == 1) {
        store.dispatch(new LogRefreshAction(
          baseModel.data.list,
        ));
      } else if (baseModel.status == 1 && page > 1) {
        store.dispatch(new LogLoadMoreAction(baseModel.data.list));
      }
      return baseModel;
    }
    return null;
  }

  static getUserProfile(uid) {
    String url = "$baseUrl?m=user/user&a=getProfile&uid=$uid";
  }

  static Future getFeedDetailAndReply(id, page, idtype) async {
    String url;
    String replyUrl;
    switch (idtype) {
      case "blogid":
        url = "$baseUrl?m=user/blog&a=getBlog&type=android&blogId=$id";
        replyUrl =
            "$baseUrl?m=user/blog&a=getBlogReply&pageSize=30&id=$id&page=$page";
        break;
//      case "albumid":
//        m = 'user/photo';
//        a = 'getPhotoMessage';
//        m1 = "user/photo";
//        a1 = 'getPhotoReply';
//        break;
      case "picid":
//        m = 'user/photo';
//        a = 'getPhotoMessage';
//        m1 = "user/photo";
//        a1 = 'getPhotoReply';
        break;
//      case "other":
//        m = 'user/photo';
//        a = 'getPhotoMessage';
//        m1 = "user/photo";
//        a1 = 'getPhotoReply';
//        break;
      default:
        url =
            "$baseUrl?m=user/user&a=getStatusComment&page=$page&pageSize=30&id=$id"; //这种不需要另外调用 评论的接口
    }

    ResultData res = await NetEngine.excute(url, null);
    print("$idtype $url ${res.data}");
    if (replyUrl != null) {
      ResultData replyRes = await NetEngine.excute(replyUrl, null);
      print("reply $idtype $replyUrl ${replyRes.data}");
    }
  }
}
