import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fz/net/service/Api.dart';
import 'package:fz/redux/FZState.dart';
import 'package:fz/util/NavigatorUtils.dart';
import 'package:fz/widget/FZListState.dart';
import 'package:fz/widget/FZPullLoadWidget.dart';
import 'package:fz/widget/FeedsItem.dart';

class LogPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LogPageState();
}

class _LogPageState extends FZListState<LogPage> with WidgetsBindingObserver {
  @override
  bool get wantKeepAlive => true;

  @override
  void didChangeDependencies() {
    pullLoadWidgetControl.dataList = getStore().state.blogModels;
    if (pullLoadWidgetControl.dataList.length == 0) {
      showRefreshLoading();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
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
    var result = await Api.getHotBlogs(getStore(), page);
    if (result.auth_status == -1) {
      //没有token 跳转登录
      NavigatorUtils.goLogin(context);
      return;
    }
  }

  requestLoadMore() async {
    //刷新请求
    var result = await Api.getHotBlogs(getStore(), page);
    if (result.auth_status == -1) {
      //没有token 跳转登录
      NavigatorUtils.goLogin(context);
      return;
    }
  }

  _renderItem(item) {
    return FeedsItem(item);
  }
}
