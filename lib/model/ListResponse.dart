class ListResponse<T> {
  bool needLoadMore;
  List<T> data;

  ListResponse({this.needLoadMore = true, this.data});
}
