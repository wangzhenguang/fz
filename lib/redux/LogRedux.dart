import 'package:fz/model/FeedsModel.dart';
import 'package:fz/redux/PhotoRedux.dart';
import 'package:redux/redux.dart';

final LogReducer = combineReducers<List<FeedsModel>>([
  TypedReducer<List<FeedsModel>, LogRefreshAction>(_refresh),
  TypedReducer<List<FeedsModel>, LogLoadMoreAction>(_loadMore)
]);

List<FeedsModel> _refresh(List<FeedsModel> list, action) {
  print(' log _refresh redux');
  list.clear();
  if (action.list == null) return list;
  if (list == null) list = new List(action.list);
  list.addAll(action.list);
  return list;
}

List<FeedsModel> _loadMore(List<FeedsModel> list, action) {
  if (action.list != null) {
    list.addAll(action.list);
  }
  return list;
}

class LogRefreshAction {
  final List<FeedsModel> list;

  LogRefreshAction(this.list);
}

class LogLoadMoreAction {
  final List<FeedsModel> list;

  LogLoadMoreAction(this.list);
}
