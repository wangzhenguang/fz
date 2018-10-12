import 'package:fz/model/photo/PhotoViewModule.dart';
import 'package:json_annotation/json_annotation.dart';
part 'PhotoModel.g.dart';
@JsonSerializable()
class PhotoModel {
  int auth_status;

  int photo_status;

  DataModel data;

  factory PhotoModel.fromJson(Map<String, dynamic> json) =>
      _$PhotoModelFromJson(json);

  PhotoModel({this.photo_status, this.data, this.auth_status});
}

@JsonSerializable()
class DataModel {
  String count;
  int more;
  String page;
  String pageSize;
  List<PhotoItemModel> list;

  factory DataModel.fromJson(Map<String, dynamic> json) =>
      _$DataModelFromJson(json);

  DataModel({this.count, this.more, this.page, this.list, this.pageSize});
}

@JsonSerializable()
class PhotoItemModel extends Photo {
  String picid;
  String albumid;
  String topicid;
  String uid;
  String username;
  String dateline;
  String title;
  String filepath;
  String thumbpic;

  PhotoItemModel(
      {this.picid,
      this.albumid,
      this.topicid,
      this.uid,
      this.username,
      this.dateline,
      this.title,
      this.filepath,
      this.thumbpic});

  factory PhotoItemModel.fromJson(Map<String, dynamic> json) =>
      _$PhotoItemModelFromJson(json);

  @override
  String getImgPath() {
    return this.filepath;
  }
}
