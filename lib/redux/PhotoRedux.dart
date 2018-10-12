import 'package:fz/model/feeds/FeedsModel.dart';
import 'package:fz/model/photo/PhotoModel.dart';
import 'package:redux/redux.dart';

final PhotoReducer = combineReducers<List<PhotoItemModel>>([
  TypedReducer<List<PhotoItemModel>, RefreshEventAction>(_refresh),
  TypedReducer<List<PhotoItemModel>, LoadMoreEventAction>(_loadMore)
]);

List<PhotoItemModel> _refresh(List<PhotoItemModel> list, action) {
  list?.clear();
  if (action.list == null) return list;
  if (list == null) list = new List(action.list);
  list.addAll(action.list);
  return list;
}

List<PhotoItemModel> _loadMore(List<PhotoItemModel> list, action) {
  if (action.list != null) {
    list.addAll(action.list);
  }
  return list;
}

class RefreshEventAction {
  final List<PhotoItemModel> list;

  RefreshEventAction(this.list);
}

class LoadMoreEventAction {
  final List<PhotoItemModel> list;

  LoadMoreEventAction(this.list);
}
