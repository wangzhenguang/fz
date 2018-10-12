import 'package:json_annotation/json_annotation.dart';

part 'UserDetailInfo.g.dart';

@JsonSerializable()
class UserDetailInfo {
  String qq;
  String msn;
  String mobile;

  //生日
  String birthyear;
  String birthmonth;
  String birthday;

  //现居
  String birthprovince;
  String birthcity;
  String resideprovince;
  String residecity;

  String lastlogin;

  String friend_count;

  String photo_count;

  String blog_count;

  String doing_count;

  String fans_count;

  String follows_count;

  String msg_id;

  int isfriend;
  String isfans;

  /// todo 这种类型的数据不知道还有多少字段
  FieldInfo info_trainwith;
  FieldInfo info_interest;
  FieldInfo info_wish;
  FieldInfo info_intro;

  int is_self;
  String avatar;
  String big_avatar;

  List<String> fields;
  List<FieldInfo> fieldInfos;

  UserDetailInfo(
      {this.qq,
      this.msn,
      this.mobile,
      this.birthyear,
      this.birthmonth,
      this.birthday,
      this.birthprovince,
      this.birthcity,
      this.resideprovince,
      this.residecity,
      this.lastlogin,
      this.friend_count,
      this.photo_count,
      this.blog_count,
      this.doing_count,
      this.fans_count,
      this.follows_count,
      this.msg_id,
      this.isfriend,
      this.isfans,
      this.info_trainwith,
      this.info_interest,
      this.info_wish,
      this.info_intro,
      this.is_self,
      this.avatar,
      this.big_avatar,
      this.fields,
      this.fieldInfos});

  factory UserDetailInfo.formatJson(Map<String, dynamic> json) {
    UserDetailInfo info = _$UserDetailInfoFromJson(json);
    //解析 fieldinfo;
    info.fieldInfos = new List();
    if (info.info_trainwith != null) {
      info.fieldInfos.add(info.info_trainwith);
    } else if (info.info_interest != null) {
      info.fieldInfos.add(info.info_interest);
    } else if (info.info_wish != null) {
      info.fieldInfos.add(info.info_wish);
    } else if (info.info_intro != null) {
      info.fieldInfos.add(info.info_intro);
    }

    info.fields.forEach((value) {
      var fieldInfoJson = json["field_$value"];
      FieldInfo fieldInfo = FieldInfo.fromJson(fieldInfoJson);
      print('$fieldInfo $value');
      info.fieldInfos.add(fieldInfo);
    });
    ///  /// todo 这种类型的数据不知道还有多少字段
    //  FieldInfo info_trainwith;
    //  FieldInfo info_interest;
    //  FieldInfo info_wish;
    //  FieldInfo info_intro; 这种也添加到集合

    return info;
  }
}

@JsonSerializable()
class FieldInfo {
  String name;
  String note;
  String value;
  List<String> choice;
  String formtype;

  ///select text
  String fieldid;

  FieldInfo(
      {this.name,
      this.note,
      this.value,
      this.choice,
      this.formtype,
      this.fieldid});

  factory FieldInfo.fromJson(Map<String, dynamic> json) {
    return _$FieldInfoFromJson(json);
  }
}

/// 示例json
//{
//    "user_status": 1,
//    "data": {
//        "data": {
//            "uid": "158886",
//            "sex": "1",
//            "newemail": "",
//            "emailcheck": "1",
//            "mobile": "",
//            "qq": "\u5bf9\u597d\u53cb\u53ef\u89c1",
//            "msn": "\u5bf9\u597d\u53cb\u53ef\u89c1",
//            "msnrobot": "",
//            "msncstatus": "0",
//            "videopic": "",
//            "birthyear": "1986",
//            "birthmonth": "11",
//            "birthday": "7",
//            "blood": "",
//            "marry": "1",
//            "birthprovince": "\u8d35\u5dde",
//            "birthcity": "\u8d35\u9633",
//            "resideprovince": "\u56db\u5ddd",
//            "residecity": "\u6210\u90fd",
//            "note": "<img src=\"image\/face\/3.gif\" class=\"face\">Yes, a crush.",
//            "spacenote": "<img src=\"image\/face\/3.gif\" class=\"face\">Yes, a crush.",
//            "authstr": "",
//            "theme": "",
//            "nocss": "0",
//            "menunum": "0",
//            "css": "",
//            "privacy": "",
//            "sendmail": "",
//            "magicstar": "0",
//            "magicexpire": "0",
//            "timeoffset": "",
//            "online": 1,
//            "lastlogin": "8\u5206\u949f\u524d",
//            "username": "\u8907\u88fd\u4eba",
//            "friend_count": "9",
//            "photo_count": "0",
//            "blog_count": "0",
//            "doing_count": "195",
//            "fans_count": "55",
//            "follows_count": "9",
//            "message": "Yes, a crush.",
//            "msg_id": "2601078",
//            "isfriend": 0,
//            "isfans": "0",
//            "info_trainwith": {
//                "name": "\u6211\u60f3\u7ed3\u4ea4",
//                "value": "\u8ba9\u5f7c\u6b64\u751f\u6d3b\u5145\u6ee1\u6fc0\u60c5\u7684\u4eba\u3002"
//            },
//            "info_interest": {
//                "name": "\u5174\u8da3\u7231\u597d",
//                "value": "\u6240\u6709\u5174\u8da3\u7231\u597d\u8be6\u89c1\u65e5\u5fd7\u3002"
//            },
//            "info_wish": {
//                "name": "\u6700\u8fd1\u5fc3\u613f",
//                "value": "\u8ba9\u81ea\u5df1\u66f4\u5f3a\u5927\u3002"
//            },
//            "info_intro": {
//                "name": "\u6211\u7684\u7b80\u4ecb",
//                "value": "\u8be6\u89c1\u65e5\u5fd7\uff08\u7b49\u5f85\u66f4\u65b0\uff09\u3002"
//            },
//            "field_22": {
//                "name": "\u7f51\u5740",
//                "note": "\u5b98\u7f51\uff0c\u535a\u5ba2\u5730\u5740\u7b49",
//                "value": "",
//                "choice": [
//                    ""
//                ],
//                "formtype": "text",
//                "fieldid": "22"
//            },
//            "fields": [
//                "22",
//                "25",
//                "31",
//                "12",
//                "13",
//                "5",
//                "32",
//                "33",
//                "20",
//                "21",
//                "30",
//                "34",
//                "1",
//                "14",
//                "15",
//                "24",
//                "35",
//                "36",
//                "16",
//                "18",
//                "27"
//            ],
//            "field_25": {
//                "name": "\u5fae\u535a",
//                "note": "\u8bf7\u5173\u6ce8\u98de\u8d5e\u5fae\u535a\uff1aweibo.com\/feizan",
//                "value": "",
//                "choice": [
//                    ""
//                ],
//                "formtype": "text",
//                "fieldid": "25"
//            },
//            "field_31": {
//                "name": "\u5fae\u4fe1",
//                "note": "\u98de\u8d5e\u5b98\u65b9\u5fae\u4fe1\u53f7\uff1aifeizan",
//                "value": "",
//                "choice": [
//                    ""
//                ],
//                "formtype": "text",
//                "fieldid": "31"
//            },
//            "field_12": {
//                "name": "\u5438\u70df",
//                "note": "",
//                "value": "\u4e0d\u5438\u70df",
//                "choice": [
//                    "\u4e0d\u5438\u70df",
//                    "\u5076\u5c14\u4ea4\u9645",
//                    "\u7ecf\u5e38\u5438\u70df",
//                    "\u6b63\u5728\u6212\u70df"
//                ],
//                "formtype": "select",
//                "fieldid": "12"
//            },
//            "field_13": {
//                "name": "\u559d\u9152",
//                "note": "",
//                "value": "\u4e0d\u559d\u9152",
//                "choice": [
//                    "\u4e0d\u559d\u9152",
//                    "\u5076\u5c14\u4ea4\u9645",
//                    "\u7ecf\u5e38\u996e\u9152",
//                    "\u6b63\u5728\u6212\u9152"
//                ],
//                "formtype": "select",
//                "fieldid": "13"
//            },
//            "field_5": {
//                "name": "\u4f53\u578b",
//                "note": "",
//                "value": "\u9b41\u68a7",
//                "choice": [
//                    "\u504f\u7626",
//                    "\u6b63\u5e38",
//                    "\u8fd0\u52a8",
//                    "\u9b41\u68a7",
//                    "\u808c\u8089",
//                    "\u4e30\u6ee1",
//                    "\u80a5\u80d6"
//                ],
//                "formtype": "select",
//                "fieldid": "5"
//            },
//            "field_32": {
//                "name": "\u4f53\u6bdb",
//                "note": "",
//                "value": "\u4e00\u822c",
//                "choice": [
//                    "\u5149\u6ed1",
//                    "\u51e0\u4e4e\u6ca1\u6709",
//                    "\u4e00\u822c",
//                    "\u591a\u6bdb"
//                ],
//                "formtype": "select",
//                "fieldid": "32"
//            },
//            "field_33": {
//                "name": "\u5934\u53d1",
//                "note": "",
//                "value": "\u77ed\u53d1",
//                "choice": [
//                    "\u5149\u5934",
//                    "\u77ed\u53d1",
//                    "\u4e2d\u7b49",
//                    "\u957f\u53d1"
//                ],
//                "formtype": "select",
//                "fieldid": "33"
//            },
//            "field_20": {
//                "name": "\u8eab\u9ad8\uff08\u5398\u7c73\uff09",
//                "note": "",
//                "value": "168",
//                "choice": [
//                    ""
//                ],
//                "formtype": "text",
//                "fieldid": "20"
//            },
//            "field_21": {
//                "name": "\u4f53\u91cd\uff08\u516c\u65a4\uff09",
//                "note": "",
//                "value": "73",
//                "choice": [
//                    ""
//                ],
//                "formtype": "text",
//                "fieldid": "21"
//            },
//            "field_30": {
//                "name": "\u5b97\u6559\u4fe1\u4ef0",
//                "note": "",
//                "value": "\u5176\u4ed6",
//                "choice": [
//                    "\u4f5b\u6559",
//                    "\u57fa\u7763\u65b0\u6559",
//                    "\u5929\u4e3b\u6559",
//                    "\u4f0a\u65af\u5170\u6559",
//                    "\u9053\u6559",
//                    "\u5176\u4ed6",
//                    "\u4e0d\u4fe1\u4ef0\u5b97\u6559"
//                ],
//                "formtype": "select",
//                "fieldid": "30"
//            },
//            "field_34": {
//                "name": "\u6559\u80b2\u7a0b\u5ea6",
//                "note": "",
//                "value": "\u7855\u58eb",
//                "choice": [
//                    "\u5c0f\u5b66",
//                    "\u521d\u4e2d",
//                    "\u4e2d\u4e13\/\u6280\u6821",
//                    "\u9ad8\u4e2d",
//                    "\u5927\u4e13",
//                    "\u672c\u79d1",
//                    "\u7855\u58eb",
//                    "\u535a\u58eb",
//                    "\u5176\u4ed6"
//                ],
//                "formtype": "select",
//                "fieldid": "34"
//            },
//            "field_1": {
//                "name": "\u604b\u7231\u503e\u5411",
//                "note": "",
//                "value": "\u540c\u6027\u7231",
//                "choice": [
//                    "\u540c\u6027\u7231",
//                    "\u53cc\u6027\u7231",
//                    "\u5f02\u6027\u7231",
//                    "\u6211\u4e5f\u4e0d\u6e05\u695a"
//                ],
//                "formtype": "select",
//                "fieldid": "1"
//            },
//            "field_14": {
//                "name": "\u51fa\u67dc\u60c5\u51b5",
//                "note": "",
//                "value": "\u53ea\u5bf9\u7236\u6bcd\u51fa\u67dc",
//                "choice": [
//                    "\u5b8c\u5168\u672a\u51fa\u67dc",
//                    "\u5bf9\u4e00\u4e9b\u4eba\u51fa\u67dc",
//                    "\u5bb6\u4eba\u5916\u5168\u51fa\u67dc",
//                    "\u5bf9\u591a\u6570\u4eba\u51fa\u67dc",
//                    "\u5b8c\u5168\u51fa\u67dc",
//                    "\u53ea\u5bf9\u7236\u6bcd\u51fa\u67dc"
//                ],
//                "formtype": "select",
//                "fieldid": "14"
//            },
//            "field_15": {
//                "name": "\u662f\u5426\u7ed3\u5a5a",
//                "note": "",
//                "value": "\u4e0d\u7ed3\u5a5a",
//                "choice": [
//                    "\u4e0d\u7ed3\u5a5a",
//                    "\u548c\u5f02\u6027\u7ed3\u5a5a",
//                    "\u548c\u540c\u6027\u7ed3\u5a5a",
//                    "\u5f62\u5f0f\u5a5a\u59fb",
//                    "\u4e0d\u4e00\u5b9a"
//                ],
//                "formtype": "select",
//                "fieldid": "15"
//            },
//            "field_24": {
//                "name": "\u604b\u7231\u89d2\u8272",
//                "note": "",
//                "value": "\u4ee5\u653b\u4e3a\u4e3b(More Top)",
//                "choice": [
//                    "\u6211\u4e0d\u8ba4\u53ef\u89d2\u8272\u5212\u5206",
//                    "\u5b8c\u5168\u4e3a\u653b(Top)",
//                    "\u4ee5\u653b\u4e3a\u4e3b(More Top)",
//                    "\u653b\u5b88\u517c\u5907(Versatile)",
//                    "\u4ee5\u5b88\u4e3a\u4e3b(More Bottom)",
//                    "\u5b8c\u5168\u4e3a\u5b88(Bottom)"
//                ],
//                "formtype": "select",
//                "fieldid": "24"
//            },
//            "field_35": {
//                "name": "\u5f02\u5730\u604b",
//                "note": "",
//                "value": "\u4e0d\u63a5\u53d7",
//                "choice": [
//                    "\u53ef\u4ee5\u63a5\u53d7",
//                    "\u4e0d\u63a5\u53d7"
//                ],
//                "formtype": "select",
//                "fieldid": "35"
//            },
//            "field_36": {
//                "name": "\u604b\u7231\u7ecf\u9a8c",
//                "note": "",
//                "value": "\u4ece\u6ca1\u8c08\u8fc7\u604b\u7231",
//                "choice": [
//                    "\u4ece\u6ca1\u8c08\u8fc7\u604b\u7231",
//                    "\u8c08\u8fc71\u6b21\u604b\u7231",
//                    "\u8c08\u8fc72\u6b21\u604b\u7231",
//                    "\u8c08\u8fc73\u6b21\u604b\u7231",
//                    "\u8c08\u8fc7\u591a\u6b21\u604b\u7231"
//                ],
//                "formtype": "select",
//                "fieldid": "36"
//            },
//            "field_16": {
//                "name": "\u661f\u5ea7",
//                "note": "",
//                "value": "\u5929\u874e\u5ea7",
//                "choice": [
//                    "\u6211\u4e0d\u76f8\u4fe1\u661f\u5ea7",
//                    "\u6c34\u74f6\u5ea7",
//                    "\u767d\u7f8a\u5ea7",
//                    "\u5de8\u87f9\u5ea7",
//                    "\u6469\u7faf\u5ea7",
//                    "\u53cc\u5b50\u5ea7",
//                    "\u72ee\u5b50\u5ea7",
//                    "\u5929\u79e4\u5ea7",
//                    "\u53cc\u9c7c\u5ea7",
//                    "\u5c04\u624b\u5ea7",
//                    "\u5929\u874e\u5ea7",
//                    "\u91d1\u725b\u5ea7",
//                    "\u5904\u5973\u5ea7"
//                ],
//                "formtype": "select",
//                "fieldid": "16"
//            },
//            "field_18": {
//                "name": "\u804c\u4e1a",
//                "note": "",
//                "value": "\u6559\u80b2\/\u57f9\u8bad",
//                "choice": [
//                    "\u4f1a\u8ba1\/\u91d1\u878d",
//                    "\u827a\u672f\/\u8bbe\u8ba1",
//                    "\u9020\u578b\/\u5316\u5986\/\u7f8e\u5bb9",
//                    "\u4f20\u64ad\/\u5a92\u4f53",
//                    "IT\/\u4e92\u8054\u7f51",
//                    "\u987e\u95ee\/\u54a8\u8be2\u670d\u52a1",
//                    "\u6559\u80b2\/\u57f9\u8bad",
//                    "\u5b66\u751f\/\u8fdb\u4fee",
//                    "\u519b\u4eba\/\u56fd\u9632",
//                    "\u5de5\u7a0b",
//                    "\u65c5\u6e38\u4e1a",
//                    "\u884c\u653f\/\u4eba\u529b",
//                    "\u653f\u5e9c\/\u516c\u52a1\u5458",
//                    "\u5236\u9020\/\u751f\u4ea7\/\u64cd\u4f5c",
//                    "\u533b\u7597\/\u536b\u751f",
//                    "\u5f8b\u5e08",
//                    "\u5efa\u7b51\/\u623f\u5730\u4ea7",
//                    "\u7814\u7a76\/\u5b66\u672f\u673a\u6784",
//                    "\u5df2\u7ecf\u9000\u4f11",
//                    "\u884c\u9500\/\u9500\u552e\/\u5e7f\u544a",
//                    "\u5931\u4e1a\/\u5f85\u4e1a\u4e2d",
//                    "\u81ea\u7531\u804c\u4e1a",
//                    "\u5176\u4ed6"
//                ],
//                "formtype": "select",
//                "fieldid": "18"
//            },
//            "field_27": {
//                "name": "\u60c5\u4fa3",
//                "note": "\u5982\u679c\u4f60\u6709\u60c5\u4fa3\u5e76\u4e14\u4e5f\u5728\u98de\u8d5e\uff0c\u8bf7\u586b\u5199TA\u7684\u98de\u8d5e\u7528\u6237\u540d",
//                "value": "\u5bf9\u597d\u53cb\u53ef\u89c1",
//                "choice": [
//                    ""
//                ],
//                "formtype": "text",
//                "fieldid": "27"
//            },
//            "avatar": "http:\/\/center.feizan.cn\/avatar\/000\/15\/88\/86_avatar_middle.jpg",
//            "big_avatar": "http:\/\/center.feizan.cn\/avatar\/000\/15\/88\/86_avatar_big.jpg",
//            "visited_count": 0,
//            "visit_count": 0,
//            "is_self": 0
//        }
//    }
//}
