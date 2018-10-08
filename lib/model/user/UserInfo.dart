import 'package:json_annotation/json_annotation.dart';
part 'UserInfo.g.dart';


@JsonSerializable()
class UserInfo {

  String uid;
  String username;
  String avatar;
  String fans_count;
  String follows_count;
  String note;


  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  UserInfo({this.uid, this.username, this.avatar, this.fans_count,
      this.follows_count, this.note});


}