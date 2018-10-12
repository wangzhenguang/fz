import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fz/model/feeds/DetailItem.dart';
import 'package:fz/model/feeds/FeedsModel.dart';
import 'package:fz/net/service/Api.dart';
import 'package:fz/redux/FZState.dart';
import 'package:fz/style/FZColors.dart';
import 'package:fz/util/FZContants.dart';
import 'package:fz/widget/FZListState.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fz/widget/FZPullLoadWidget.dart';
import 'package:fz/widget/FeedsReplyItem.dart';

class FeedsDetailPage extends StatefulWidget {
  final FeedsModel feedsModel;

  FeedsDetailPage(this.feedsModel) : super();

  @override
  State<StatefulWidget> createState() => _FeedsDetailState();
}

class _FeedsDetailState extends FZListState<FeedsDetailPage> {
  @override
  bool get wantKeepAlive => false;

  @override
  void didChangeDependencies() {
    pullLoadWidgetControl.dataList = new List();
    if (pullLoadWidgetControl.dataList.length == 0) {
      showRefreshLoading();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<FZState>(builder: (context, store) {
      return Scaffold(
        appBar: AppBar(
          title: Text("动态详情"),
        ),
        body: FZPullLoadWidget(
          pullLoadWidgetControl,
          handleRefresh,
          onLoadMore,
          refreshKey: refreshIndicatorKey,
          itemBuilder: (context, index) => _renderItem(index),
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
    _requestData();
  }

  _requestData() {
    Api.getFeedDetailAndReply(
      widget.feedsModel,
      page,
    ).then((res) {
      setState(() {
        pullLoadWidgetControl.needLoadMore = res.needLoadMore;
        if (page == 0)
          pullLoadWidgetControl.dataList = res.data;
        else {
          pullLoadWidgetControl.dataList.addAll(res.data);
        }
      });
    });
  }

  _renderItem(int index) {
    DetailItem data = pullLoadWidgetControl.dataList[index];
    if (widget.feedsModel.idtype == 'blogid' && index == 0) {
      var str = data.content.replaceAll("<IMG", "<img");

      return Column(
        children: <Widget>[
          Html(
            data: str,
            defaultTextStyle: TextStyle(color: Color(FZColors.textGray)),
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          ),
          new Container(
            color: Color(FZColors.cellBlackBg),
            height: 10.0,
          ),
        ],
      );
    } else if (widget.feedsModel.idtype == 'picid' && index == 0) {
      return FadeInImage.assetNetwork(
          placeholder: FZContants.IMG_PLACEHOLDER, image: data.content);
    }
    return Column(
      children: <Widget>[
        FeedsReplyItem(data),
        Divider(
          color: Color(FZColors.textGray),
        ),
      ],
    );
  }
}
