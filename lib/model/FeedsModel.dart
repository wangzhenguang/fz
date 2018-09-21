import 'package:json_annotation/json_annotation.dart';

part 'FeedsModel.g.dart';

@JsonSerializable()
class BaseModel {
  int feed_status;

  int auth_status;

  DataModel data;

  factory BaseModel.fromJson(Map<String, dynamic> json) =>
      _$BaseModelFromJson(json);

  BaseModel({this.feed_status, this.data,this.auth_status});
}

@JsonSerializable()
class DataModel {
  int count;
  int more;
  int page;
  int pageSize;
  List<FeedsModel> list;

  factory DataModel.fromJson(Map<String, dynamic> json) =>
      _$DataModelFromJson(json);

  DataModel({this.count, this.more, this.page, this.list, this.pageSize});
}


@JsonSerializable()
class FeedsModel {
  String feedid;
  String uid;
  String avatar;
  String username;
  String dateline;
  String time;
  String hot;
  String id;
  String blogid;
  String doid;
  String idtype;
  String title;
  String message;
  String title_message;
  String image_1;
  String image_2;
  String touid;
  String touser;


  FeedsModel({this.feedid, this.uid, this.avatar, this.username, this.dateline,
      this.time, this.hot, this.id, this.blogid, this.doid, this.idtype,
      this.title, this.message, this.title_message, this.image_1, this.image_2,
      this.touid, this.touser});

  factory FeedsModel.fromJson(Map<String, dynamic> json) => _$FeedsModelFromJson(json);
}

