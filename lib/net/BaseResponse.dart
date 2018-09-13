import 'dart:convert' show json;

class BaseReponse<T> {
  int code;
  String msg;
  T data;

  factory BaseReponse(jsonStr, Function buildFun) => jsonStr is String
      ? BaseReponse.fromJson(json.decode(jsonStr), buildFun)
      : BaseReponse.fromJson(jsonStr, buildFun);

  BaseReponse.fromJson(jsonRes, Function buildFun) {
    code = jsonRes["code"];
    msg = jsonRes["msg"];

    data = buildFun(jsonRes['data']);
  }
}
