import 'package:json_annotation/json_annotation.dart';

part 'NearbyModel.g.dart';

@JsonSerializable()
class NearbyModel {
  int auth_status;

  int search_status;

  DataModel data;

  factory NearbyModel.fromJson(Map<String, dynamic> json) =>
      _$NearbyModelFromJson(json);

  NearbyModel({this.search_status, this.data, this.auth_status});
}

@JsonSerializable()
class DataModel {
  int more;
  String page;
  String pageSize;
  List<NearbyItemModel> user;

  factory DataModel.fromJson(Map<String, dynamic> json) =>
      _$DataModelFromJson(json);

  DataModel({ this.more, this.page, this.user, this.pageSize});
}

@JsonSerializable()
class NearbyItemModel {
  var uid;
  var username;
  var feedfriend;
  var resideprovince;
  var about;
  var message;
  var msg_id;
  var online;
  var lastlogin;
  var addr;
  var distance;
  var avatar;
  var big_avatar;
  var isfriend;

  NearbyItemModel(
      {this.uid,
      this.username,
      this.feedfriend,
      this.resideprovince,
      this.about,
      this.message,
      this.msg_id,
      this.online,
      this.lastlogin,
      this.addr,
      this.distance,
      this.avatar,
      this.big_avatar,
      this.isfriend});

  factory NearbyItemModel.fromJson(Map<String, dynamic> json) =>
      _$NearbyItemModelFromJson(json);
}
