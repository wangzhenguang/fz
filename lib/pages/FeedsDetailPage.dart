import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fz/net/service/Api.dart';
import 'package:fz/redux/FZState.dart';
import 'package:fz/util/NavigatorUtils.dart';
import 'package:fz/widget/FZListState.dart';
import 'package:fz/widget/FZPullLoadWidget.dart';
import 'package:fz/widget/FeedsItem.dart';

class FeedsDetailPage extends StatefulWidget {
  final String id;
  final String idType;

  FeedsDetailPage(this.id, this.idType) : super();

  @override
  State<StatefulWidget> createState() => _FeedsDetailState();
}

//class _FeedsDetailState extends State<FeedsDetailPage> {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("记录详情"),
//        centerTitle: true,
//      ),
//    );
//  }
//}

class _FeedsDetailState extends FZListState<FeedsDetailPage> {
  @override
  bool get wantKeepAlive => false;

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<FZState>(builder: (context, store) {
      return Scaffold(
        appBar: AppBar(
          title: Text("动态详情1"),
        ),
        body: FZPullLoadWidget(
          pullLoadWidgetControl,
          handleRefresh,
          onLoadMore,
          refreshKey: refreshIndicatorKey,
          itemBuilder: (context, index) =>
              _renderItem(pullLoadWidgetControl.dataList[index]),
        ),
      );
    });
  }

  @override
  requestRefresh() {
    //刷新请求
    _requestData();
  }

  @override
  requestLoadMore() {
    //刷新请求
  }

  _requestData() {
    Api.getFeedDetailAndReply(widget.id, page, widget.idType).then((res) {
      print('$res res' );
    });
  }

  _renderItem(item) {
    return FeedsItem(item);
  }
}
