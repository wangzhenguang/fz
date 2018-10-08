import 'package:fz/model/nearby/NearbyModel.dart';
import 'package:redux/redux.dart';

final NearbyReducer = combineReducers<List<NearbyItemModel>>([
  TypedReducer<List<NearbyItemModel>, NearbyRefreshAction>(_refresh),
  TypedReducer<List<NearbyItemModel>, NearbyLoadMoreAction>(_loadMore)
]);

List<NearbyItemModel> _refresh(List<NearbyItemModel> list, action) {
  list?.clear();
  if (action.list == null) return list;
  list.addAll(action.list);
  return list;
}

List<NearbyItemModel> _loadMore(List<NearbyItemModel> list, action) {
  if (action.list != null) {
    list.addAll(action.list);
  }
  return list;
}

class NearbyRefreshAction {
  final List<NearbyItemModel> list;

  NearbyRefreshAction(this.list);
}

class NearbyLoadMoreAction {
  final List<NearbyItemModel> list;

  NearbyLoadMoreAction(this.list);
}
