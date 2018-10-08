import 'package:json_annotation/json_annotation.dart';
part 'FeedsDetailModule.g.dart';

@JsonSerializable()
class FeedsDetailModule {
  String doid;
  String uid;
  String username;
  String from;
  String dateline;
  String message;

//  String replynum;
  String avatar;
  List<FeedsReplyModule> list;

  factory FeedsDetailModule.fromJson(Map<String, dynamic> json) =>
      _$FeedsDetailModuleFromJson(json);

  FeedsDetailModule(
      {this.doid,
      this.uid,
      this.username,
      this.from,
      this.dateline,
      this.message,
      this.avatar,
      this.list});
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

  FeedsReplyModule(
      {this.id,
      this.doid,
      this.uid,
      this.username,
      this.dateline,
      this.message,
      this.avatar});

  factory FeedsReplyModule.fromJson(Map<String, dynamic> json) =>
      _$FeedsReplyModuleFromJson(json);
}
