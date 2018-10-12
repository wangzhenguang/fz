import 'package:fz/model/feeds/FeedsModel.dart';
import 'package:fz/redux/PhotoRedux.dart';
import 'package:redux/redux.dart';

final FeedsReducer = combineReducers<List<FeedsModel>>([
  TypedReducer<List<FeedsModel>, FeedsRefreshAction>(_refresh),
  TypedReducer<List<FeedsModel>, FeedsLoadMoreAction>(_loadMore)
]);

List<FeedsModel> _refresh(List<FeedsModel> list, action) {
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

class FeedsRefreshAction {
  final List<FeedsModel> list;

  FeedsRefreshAction(this.list);
}

class FeedsLoadMoreAction {
  final List<FeedsModel> list;

  FeedsLoadMoreAction(this.list);
}
