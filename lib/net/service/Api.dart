import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fz/config/Config.dart';
import 'package:fz/model/ListResponse.dart';
import 'package:fz/model/feeds/FeedsModel.dart';
import 'package:fz/model/feeds/DetailItem.dart';
import 'package:fz/model/feeds/FeedsDetailModule.dart';
import 'package:fz/model/nearby/NearbyModel.dart';
import 'package:fz/model/photo/PhotoModel.dart';
import 'package:fz/model/user/UserDetailInfo.dart';
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
import 'package:fz/util/NavigatorUtils.dart';
import 'package:redux/redux.dart';

class Api {
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
    ResultData res =
        await NetEngine.excute(loginUrl, params: params, method: "post");
    if (res != null && res.code == NetCode.SUCCESS) {
      if (res.data["account_status"] == 1) {
        NetEngine.saveToken(res.data['auth_token']);
        // 保存用户数据
        await LocalStorage.save(USER_INFO, json.encode(res.data["data"]));
        await LocalStorage.save(USER_TOKEN, res.data['auth_token']);
      }

      return res.data;
    }
  }

  static Future<BaseModel> getFeeds(Store store, page) async {
    ResultData res = await NetEngine.excute("$feedsUrl$page");
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

    ResultData res = await NetEngine.excute(allPhotos);
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
    NetEngine.excute(updateLocationUrl);
  }

  static getNearUsers(store, latitude, longitude, int page) async {
    String url =
        "$baseUrl?m=search/friend&a=getNearUsers&pageSize=32&latitude=$latitude&longitude=$longitude&page=$page";
    ResultData res = await NetEngine.excute(url);
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

    ResultData res = await NetEngine.excute(url);
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

  static Future<UserDetailInfo> getUserProfile(uid) async {
    String url = "$baseUrl?m=user/user&a=getProfile&uid=$uid";
    ResultData res = await NetEngine.excute(url);
    if (res.data['user_status'] == 1) {
      //获取个人信息成功
      var json = res.data['data']['data'];
      UserDetailInfo userDetailInfo = UserDetailInfo.formatJson(json);
      return userDetailInfo;
    }

    return null;
  }

  ///
  ///  获取日志，记录，相册和评论
  static Future<ListResponse<DetailItem>> getFeedDetailAndReply(
      FeedsModel model, page) async {
    String url;
    String replyUrl;
    switch (model.idtype) {
      case "blogid":
        if (page == 1) //日志类型 加载更多时 不需要再次获取头部日志信息
          url =
              "$baseUrl?m=user/blog&a=getBlog&type=android&blogId=${model.id}";
        replyUrl =
            "$baseUrl?m=user/blog&a=getBlogReply&pageSize=30&blogId=${model.id}&page=$page";
        break;
      case "picid":
        if (page == 1)
          url = "$baseUrl?m=user/photo&a=getPhotoMessage&id=${model.id}";
        else
          replyUrl =
              "$baseUrl?m=user/photo&a=getPhotoReply&id=${model.id}&page=$page";
        break;
      default:
        //这种不需要另外调用 评论的接口
        url =
            "$baseUrl?m=user/user&a=getStatusComment&page=$page&pageSize=30&id=${model.id}";
    }
    List<DetailItem> data = List();
    bool needLoadMore = true;
    print('${model.idtype}');
    if (url != null) {
      ResultData res = await NetEngine.excute(url);
      if (res.code == 200 && res.data != null) {
        var result = res.data['data'];
        if (res.data["status"] == 1 && model.idtype == 'blogid') {
          //成功获取到数据
          //日志没有评论数据 需要调用另外的接口
          data.add(DetailItem(
              id: result["blogid"],
              uid: model.uid,
              avatar: model.avatar,
              content: result["message"],
              userName: result["username"],
              dateline: result['dateline']));
        } else if (res.data["photo_status"] == 1 && model.idtype == 'picid') {
          //成功获取到数据
          // 照片评论数据  第二页开始需要另外调用评论列表接口
          data.add(DetailItem(
              id: result["picid"],
              uid: model.uid,
              avatar: model.avatar,
              content: result["filepath"],
              userName: result["username"],
              dateline: result['dateline']));

          FeedsDetailModule module =
              FeedsDetailModule.fromJson(result['comments']);
          needLoadMore = result['comments']['more'] > 0;
          module.list?.forEach((e) {
            data.add(DetailItem(
                avatar: e.avatar,
                uid: e.uid == null ? e.authorid : e.uid,
                content: e.message,
                id: e.id,
                userName: e.author == null ? e.username : e.author,
                dateline: e.dateline));
          });
        } else if (res.data['status'] == 1) {
          /// 这种类型 评论 和记录 都在此接口 不需要额外调用评论列表接口
          FeedsDetailModule module = FeedsDetailModule.fromJson(result);
          needLoadMore = result['more'] > 0;
          data.add(DetailItem(
              avatar: module.avatar,
              uid: module.uid,
              content: module.message,
              imgPath: module.filepath,
              userName: module.username,
              dateline: model.dateline,
              id: module.doid));
          module.list?.forEach((e) {
            data.add(DetailItem(
                avatar: e.avatar,
                uid: e.uid == null ? e.authorid : e.uid,
                content: e.message,
                id: e.id,
                userName: e.author == null ? e.username : e.author,
                dateline: e.dateline));
          });
        }
      }
    }

    if (replyUrl != null) {
      /// 获取评论列表 并 组装数据
      ResultData replyRes = await NetEngine.excute(replyUrl);
      print("reply ${model.idtype} $replyUrl ${replyRes.data}");
      if (replyRes.code == 200) {
        FeedsDetailModule module =
            FeedsDetailModule.fromJson(replyRes.data['data']);
        needLoadMore = replyRes.data['data']['more'] > 0;

        module.list?.forEach((e) {
          data.add(DetailItem(
              avatar: e.avatar,
              uid: e.uid == null ? e.authorid : e.uid,
              content: e.message,
              id: e.id,
              userName: e.author == null ? e.username : e.author,
              dateline: e.dateline));
        });
      }
    }

    ///将数据重新组装成一个list
    /// 判断是否需要加载更多

    return ListResponse<DetailItem>(data: data, needLoadMore: needLoadMore);
  }

  static getAlbum(context, String uid) async {
    String url = '$baseUrl?m=user/photo&a=getPhotoListV1&uid=$uid';
    ResultData res = await NetEngine.excute(url);
    if (res.data['auth_status'] == 1) {
      NavigatorUtils.goUntilLoginPage(context);
      return null;
    }


    
  }
}
