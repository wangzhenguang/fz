import 'package:json_annotation/json_annotation.dart';
part 'FeedsDetailModule.g.dart';

@JsonSerializable()
class FeedsDetailModule {
  String doid;
  String uid;
  String username;
  String from;
  String dateline; // 照片的时候这个字段为数字 其他时为具体多少分钟、时前
  String message;
  String picid;
  String albumid;
  String filepath;
  String thumbpic;
  String title;
  String avatar;

  List<FeedsReplyModule> list;

  factory FeedsDetailModule.fromJson(Map<String, dynamic> json) =>
      _$FeedsDetailModuleFromJson(json);

  FeedsDetailModule({this.doid, this.uid, this.username, this.from,
      this.dateline, this.message, this.picid, this.albumid, this.filepath,
      this.thumbpic, this.title, this.avatar, this.list});

  @override
  String toString() {
    return 'FeedsDetailModule{doid: $doid, uid: $uid, username: $username, from: $from, dateline: $dateline, message: $message, picid: $picid, albumid: $albumid, filepath: $filepath, thumbpic: $thumbpic, title: $title, avatar: $avatar, list: $list}';
  }


}

@JsonSerializable()
class FeedsReplyModule {
  String id;
  String doid;
  String uid;
  String username;
  String dateline;
  String message;
  String avatar;
  String authorid;
  String author;
  String cid;


  FeedsReplyModule({this.id, this.doid, this.uid, this.username, this.dateline,
      this.message, this.avatar, this.authorid, this.author, this.cid});

  factory FeedsReplyModule.fromJson(Map<String, dynamic> json) =>
      _$FeedsReplyModuleFromJson(json);

  @override
  String toString() {
    return 'FeedsReplyModule{id: $id, doid: $doid, uid: $uid, username: $username, dateline: $dateline, message: $message, avatar: $avatar, authorid: $authorid, author: $author, cid: $cid}';
  }


}
