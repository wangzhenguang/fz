import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fz/model/feeds/FeedsModel.dart';
import 'package:fz/net/service/Api.dart';
import 'package:fz/redux/FZState.dart';
import 'package:fz/util/NavigatorUtils.dart';
import 'package:fz/widget/FZListState.dart';
import 'package:fz/widget/FZPullLoadWidget.dart';
import 'package:fz/widget/FeedsItem.dart';
import 'package:redux/redux.dart';

class DynamicPage extends StatefulWidget {
  @override
  createState() => _DynamicPageState();
}

class _DynamicPageState extends FZListState<DynamicPage>
    with WidgetsBindingObserver {
  @override
  void didChangeDependencies() {
    pullLoadWidgetControl.dataList = getStore().state.feeds;
    if (pullLoadWidgetControl.dataList.length == 0) {
      showRefreshLoading();
    }
    super.didChangeDependencies();
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StoreBuilder<FZState>(
      builder: (context, store) {
        return FZPullLoadWidget(
          pullLoadWidgetControl,
          handleRefresh,
          onLoadMore,
          refreshKey: refreshIndicatorKey,
          itemBuilder: (context, index) =>
              _renderItem(pullLoadWidgetControl.dataList[index]),
        );
      },
    );
  }

  @override
  requestRefresh() async {
    //刷新请求
    BaseModel result = await Api.getFeeds(getStore(), page);
    if (result.auth_status == -1) {
      //没有token 跳转登录
      NavigatorUtils.goLogin(context);
      return;
    }
  }

  requestLoadMore() async {
    //加载更多
    BaseModel result = await Api.getFeeds(getStore(),page);
    if (result?.auth_status == -1) {
      //没有token 跳转登录
      NavigatorUtils.goLogin(context);
      return;
    }else if(result == null){
      return ;
    }
  }

  _renderItem(item) {
    return new FeedsItem(item);
  }
}
