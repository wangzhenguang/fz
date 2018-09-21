import 'dart:io';

import 'package:dio/dio.dart';
import 'package:connectivity/connectivity.dart';
import 'package:fz/net/ResultData.dart';
import 'package:fz/net/NetCode.dart';
import 'package:fz/config/Config.dart';
import 'package:fz/net/service/Api.dart';
import 'package:fz/util/LocalStorage.dart';

class NetEngine {
  static Options options = new Options(
      baseUrl: "http://api.feizan.com/",
      connectTimeout: 5000,
      receiveTimeout: 3000,
      contentType: ContentType.json);

  static excute(url, params, {noTip = false, method = "get"}) async {
    // 判断网咯情况
    var connectResult = await new Connectivity().checkConnectivity();
    if (connectResult == ConnectivityResult.none) {
      //没有网络
      return ResultData(
          NetCode.errorHandleFunction(NetCode.NETWORK_ERROR, "无法连接到网络", true),
          NetCode.NETWORK_ERROR);
    }
    options.method = method;

    var token =  await LocalStorage.get(Api.USER_TOKEN);
    if(token!= null){
      saveToken(token);
    }

    Dio dio = new Dio();
    Response response;
    try {
      response = await dio.request(url, data: params, options: options);
    } on DioError catch (e) {
      Response errorResponse = e.response == null
          ? new Response(statusCode: NetCode.NETWORK_UNKNOW_EXCEPTION)
          : e.response;

      if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        errorResponse.statusCode = NetCode.NETWORK_TIMEOUT;
        errorResponse.data = "网络连接超时";
      } else {
        errorResponse.statusCode = NetCode.NETWORK_TIMEOUT;
        errorResponse.data = "未知错误";
      }

      if (Config.DEBUG) {
        print('请求异常 ${e.toString()}');
        print('请求url $url');
      }

      return ResultData(
          NetCode.errorHandleFunction(
              errorResponse.statusCode, errorResponse.data, noTip),
          errorResponse.statusCode);
    }

    if (Config.DEBUG) {
      print('请求url $url');
      print('token ${options.headers['token']}');
      if (params != null) print("请求参数 ${params.toString()}");
    }

    var result = response.data;
    try {
      if (response.statusCode == 200) {
        return new ResultData(result, response.statusCode);
      } else {
        //网络错误 提示信息
        return ResultData(
            NetCode.errorHandleFunction(response.statusCode, "", noTip),
            response.statusCode);
      }
    } catch (e) {
      return new ResultData(null, response.statusCode);
    }
  }

  static saveToken(token) {
    options.headers.addAll({"token": token});
  }

  static removeToken() {
    options.headers.remove("token");
  }
}
