class PhotoViewModule<T extends Photo> {

  List<T> list;
  int curIndex;
}

abstract class Photo {
  String getImgPath();
}
