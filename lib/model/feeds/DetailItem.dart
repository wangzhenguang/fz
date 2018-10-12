

class DetailItem{

  String avatar;
  String uid;
  String content;
  String id;
  String userName;
  String imgPath;
  String dateline;

  DetailItem({this.avatar, this.uid, this.content, this.id, this.userName,this.imgPath,this.dateline});

  @override
  String toString() {
    return 'DetailItem{avatar: $avatar, uid: $uid, content: $content, id: $id, userName: $userName, imgPath: $imgPath, dateline: $dateline}';
  }


}