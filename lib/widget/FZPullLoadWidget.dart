import 'package:flutter/material.dart';
import 'package:fz/model/feeds/FeedsModel.dart';
import 'package:fz/style/FZColors.dart';
import 'package:fz/style/FZString.dart';
import 'package:fz/style/FZTextStyle.dart';
import 'package:fz/style/FZIconfont.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FZPullLoadWidget extends StatefulWidget {
  /// item渲染
  final IndexedWidgetBuilder itemBuilder;

  final RefreshCallback onLoadMore;

  final RefreshCallback onRefresh;

  final FZPullLoadWidgetControl control;

  final Key refreshKey;

  //大于2位gridView;
  final int columns;

  final IndexedWidgetBuilder renderGridViewItem;

  final bool showLoadMoreItem;

  final double childAspectRatio;

  FZPullLoadWidget(this.control, this.onRefresh, this.onLoadMore,
      {this.refreshKey,
      this.columns = 1,
      this.itemBuilder,
      this.showLoadMoreItem = true,
      this.renderGridViewItem,
      this.childAspectRatio = 1.0});

  @override
  State<StatefulWidget> createState() {
    return _FZPullLoadWidgetState();
  }
}

class _FZPullLoadWidgetState extends State<FZPullLoadWidget> {
  final ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    //滑动监听
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (widget.control.needLoadMore) {
          widget.onLoadMore?.call();
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new RefreshIndicator(
        key: widget.refreshKey,
        child: widget.columns == 1 || _getListCount() == 1
            ? new ListView.builder(
                ///保持ListView任何情况都能滚动，解决在RefreshIndicator的兼容问题。
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return _getItem(index);
                },
                itemCount: _getListCount(),
                controller: _scrollController,
              )
            : GridView.count(
                crossAxisCount: widget.columns,
                controller: _scrollController,
                childAspectRatio: widget.childAspectRatio,
//                crossAxisSpacing: 10.0,
//                mainAxisSpacing: 10.0,
                physics: const AlwaysScrollableScrollPhysics(),
                children: List.generate(_getListCount(), (index) {
                  return _getItem(index);
                }),
              ),
        onRefresh: widget.onRefresh);
  }

  ///根据配置状态返回实际列表数量
  ///实际上这里可以根据你的需要做更多的处理
  ///比如多个头部，是否需要空页面，是否需要显示加载更多。
  _getListCount() {
    ///是否需要头部
    if (widget.control.needHeader) {
      ///如果需要头部，用Item 0 的 Widget 作为ListView的头部
      ///列表数量大于0时，因为头部和底部加载更多选项，需要对列表数据总数+2
      return (widget.control.dataList.length > 0 && widget.showLoadMoreItem)
          ? widget.control.dataList.length + 2
          : widget.control.dataList.length + 1;
    } else {
      ///如果不需要头部，在没有数据时，固定返回数量1用于空页面呈现
      if (widget.control.dataList.length == 0) {
        return 1;
      }

      ///如果有数据,因为部加载更多选项，需要对列表数据总数+1
      return (widget.control.dataList.length > 0 && widget.showLoadMoreItem)
          ? widget.control.dataList.length + 1
          : widget.control.dataList.length;
    }
  }

  ///根据配置状态返回实际列表渲染Item
  _getItem(int index) {
    if (!widget.control.needHeader &&
        index == widget.control.dataList.length &&
        widget.control.dataList.length != 0 &&
        widget.showLoadMoreItem) {
      ///如果不需要头部，并且数据不为0，当index等于数据长度时，渲染加载更多Item（因为index是从0开始）
      return _buildProgressIndicator();
    } else if (widget.control.needHeader &&
        index == _getListCount() - 1 &&
        widget.control.dataList.length != 0) {
      ///如果需要头部，并且数据不为0，当index等于实际渲染长度 - 1时，渲染加载更多Item（因为index是从0开始）
      return _buildProgressIndicator();
    } else if (!widget.control.needHeader &&
        widget.control.dataList.length == 0) {
      ///如果不需要头部，并且数据为0，渲染空页面
      return _buildEmpty();
    } else {
      ///回调外部正常渲染Item，如果这里有需要，可以直接返回相对位置的index
      return widget.itemBuilder(context, index);
    }
  }

  ///空页面
  Widget _buildEmpty() {
    return new Container(
      height: MediaQuery.of(context).size.height - 100,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
              onPressed: () {},
              child: new Icon(
                FZIconFont.mine,
                size: 70.0,
              )),
          Container(
            child: Text(FZString.app_empty, style: FZTextStyle.normalText),
          ),
        ],
      ),
    );
  }

  ///上拉加载更多
  Widget _buildProgressIndicator() {
    ///是否需要显示上拉加载更多的loading
    Widget bottomWidget = (widget.control.needLoadMore)
        ? new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                ///loading框
                new SpinKitRotatingCircle(color: Color(FZColors.textGray)),
                new Container(
                  width: 5.0,
                ),

                ///加载中文本
                new Text(
                  FZString.load_more_text,
                  style: TextStyle(
                    color: Color(FZColors.textGray),
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ])

        /// 不需要加载
        : new Container();
    return new Padding(
      padding: const EdgeInsets.all(20.0),
      child: new Center(
        child: bottomWidget,
      ),
    );
  }
}

class FZPullLoadWidgetControl {
  ///数据，对齐增减，不能替换
  List dataList = new List();

  ///是否需要加载更多
  bool needLoadMore = true;

  ///是否需要头部
  bool needHeader = false;
}
