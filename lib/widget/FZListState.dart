import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fz/net/NetCode.dart';
import 'package:fz/redux/FZState.dart';
import 'package:fz/widget/FZPullLoadWidget.dart';
import 'package:redux/redux.dart';

abstract class FZListState<T extends StatefulWidget> extends State<T>
    with AutomaticKeepAliveClientMixin {
  bool isShow = false;
  bool isLoading = false;
  int page = 1;

  final List dataList = new List();

  @protected
  Store<FZState> getStore() {
    return StoreProvider.of(context);
  }


  final FZPullLoadWidgetControl pullLoadWidgetControl =
      new FZPullLoadWidgetControl();

  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey = new GlobalKey();

  @override
  void initState() {
    isShow = true;
    super.initState();
    pullLoadWidgetControl.needHeader = needHeader;
    pullLoadWidgetControl.dataList = dataList;
    if (pullLoadWidgetControl.dataList.length == 0 && isRefreshFirst) {
      showRefreshLoading();
    }
  }

  showRefreshLoading() {
    print("showRefreshLoading");
    Future.delayed(Duration(seconds: 0), () {
      refreshIndicatorKey.currentState.show().then((e) {});
      return true;
    });
  }

  @protected
  resolveRefreshResult(res) {
    if (res != null && res.code == NetCode.SUCCESS) {
      pullLoadWidgetControl.dataList.clear();
      if (isShow) {
        setState(() {
          pullLoadWidgetControl.dataList.addAll(res.data);
        });
      }
    }
  }

  @protected
  Future<Null> handleRefresh() async {
    if (isLoading) {
      return null;
    }
    isLoading = true;
    page = 1;
    requestRefresh(); //调用刷新回调
//    resolveRefreshResult(res); //
    /// todo 解析返回的数据 看是否需要判断需要加载更多
//    if (res?.next != null) {
//      var resNext = await res.next;
//      resolveRefreshResult(resNext); //
//    }
    isLoading = false;
    return null;
  }

  @protected
  Future<Null> onLoadMore() async {
    if (isLoading) {
      return null;
    }
    isLoading = true;
    page++;
    requestLoadMore();
//    if (res != null && res.code == NetCode.SUCCESS) {
//      if (isShow) {
//        setState(() {
//          pullLoadWidgetControl.dataList.addAll(res.data);
//        });
//      }
//    }
    isLoading = false;
    return null;
  }

  @protected
  clearData() {
    if (isShow) {
      setState(() {
        pullLoadWidgetControl.dataList.clear();
      });
    }
  }

  List get getDataList => dataList;

  @protected
  requestRefresh() async {}

  @protected
  requestLoadMore() async {}

  @protected
  bool get needHeader => false;

  @protected
  bool get isRefreshFirst => false;

  @override
  bool get wantKeepAlive => true;

  @override
  int get columns => 1;

  @override
  void dispose() {
    isLoading = false;
    isShow = false;
    super.dispose();
  }
}
