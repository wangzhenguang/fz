import 'package:fz/model/photo/PhotoViewModule.dart';
import 'package:json_annotation/json_annotation.dart';
part 'AlbumModel.g.dart';

@JsonSerializable()
class AlbumModel{
  String albumid;
  String albumname;
  String uid;
  String username;
  String updatetime;
  String picnum;
  String thumbpic;
  String password;


  AlbumModel({this.albumid, this.albumname, this.uid, this.username,
      this.updatetime, this.picnum, this.thumbpic, this.password});

  factory AlbumModel.fromJson(Map<String, dynamic> json) =>
      _$AlbumModelFromJson(json);

}