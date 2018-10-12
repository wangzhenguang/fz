import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fz/model/photo/PhotoModel.dart';
import 'package:fz/model/photo/PhotoViewModule.dart';
import 'package:fz/redux/FZState.dart';
import 'package:fz/util/FZContants.dart';
import 'package:fz/util/NavigatorUtils.dart';
import 'package:fz/widget/FZListState.dart';
import 'package:fz/widget/FZPullLoadWidget.dart';
import 'package:fz/net/service/Api.dart';

class PhotoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PhotoPageState();
  }
}

class _PhotoPageState extends FZListState<PhotoPage>
    with WidgetsBindingObserver {
  @override
  void didChangeDependencies() {
    pullLoadWidgetControl.dataList = getStore().state.photos;
    if (pullLoadWidgetControl.dataList.length == 0) {
      showRefreshLoading();
    }
    super.didChangeDependencies();
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
          columns: 4, //4列
          showLoadMoreItem: false,
          refreshKey: refreshIndicatorKey,
          itemBuilder: (context, index) => _renderItem(context, index),
        );
      },
    );
  }

  @override
  requestRefresh() async {
    //刷新请求
    print("photo requestRefresh");
    PhotoModel result = await Api.getAllPhotos(getStore(), page);
    pullLoadWidgetControl.needLoadMore = true;
    if (result?.auth_status == -1) {
      //没有token 跳转登录
      NavigatorUtils.goLogin(context);
      return;
    }
  }

  @override
  requestLoadMore() async {
    print("photo requestLoadMore");

    PhotoModel result = await Api.getAllPhotos(getStore(), page);
    if (result?.auth_status == -1) {
      //没有token 跳转登录
      NavigatorUtils.goLogin(context);
      return;
    } else if (result?.data?.list == null || result?.data?.list?.length == 0) {
      page--;
      pullLoadWidgetControl.needLoadMore = false;
    }
  }

  _renderItem(context, index) {
    if (pullLoadWidgetControl.dataList.length == 0) {
      return Text("没有照片！！！");
    }

    PhotoItemModel data = pullLoadWidgetControl.dataList[index];
    return GestureDetector(
      child: FadeInImage.assetNetwork(
          fit: BoxFit.cover,
          placeholder: FZContants.IMG_PLACEHOLDER,
          image: data.thumbpic??""),
      onTap: () {
        PhotoViewModule photoViewModule = PhotoViewModule();
        photoViewModule.list = pullLoadWidgetControl.dataList;
        photoViewModule.curIndex= index;
        NavigatorUtils.goPhotoViewPage(context, photoViewModule);
      },
    );
  }
}
