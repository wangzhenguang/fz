import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fz/model/nearby/NearbyModel.dart';
import 'package:fz/net/service/Api.dart';
import 'package:fz/redux/FZState.dart';
import 'package:fz/style/FZColors.dart';
import 'package:fz/util/NavigatorUtils.dart';
import 'package:fz/widget/FZListState.dart';
import 'package:fz/widget/FZPullLoadWidget.dart';
import 'package:location/location.dart';

class NearbyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NearbyPageState();
  }
}

class _NearbyPageState extends FZListState<NearbyPage>
    with WidgetsBindingObserver {
  final _location = new Location();
  Map<String, double> currentLocation;
  double cellWidth;

  bool _permission = false;
  String error;

  @override
  void didChangeDependencies() {
    pullLoadWidgetControl.dataList = getStore().state.nearbyModels;
    if (pullLoadWidgetControl.dataList.length == 0) {
      showRefreshLoading();
    }
    super.didChangeDependencies();
  }

  requestLocation() async {
    Map<String, double> location;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      _permission = await _location.hasPermission();
      location = await _location.getLocation();
      error = null;
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Permission denied';
      } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error =
            'Permission denied - please ask the user to enable it from the app settings';
      }

      location = null;
    }
    return location;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    num screenWidth = MediaQuery.of(context).size.width;
    cellWidth = screenWidth / 4;
    return StoreBuilder<FZState>(
      builder: (context, store) {
        return FZPullLoadWidget(
          pullLoadWidgetControl,
          handleRefresh,
          onLoadMore,
          columns: 4,
          //4列
          childAspectRatio: 0.64,
          refreshKey: refreshIndicatorKey,
          showLoadMoreItem: false,
          itemBuilder: (context, index) => _renderItem(context, index),
        );
      },
    );
  }

  @override
  requestRefresh() async {
    // 获取 location
    currentLocation = await requestLocation();
    if (error == null) {
      print(currentLocation["latitude"]);
      print(currentLocation["longitude"]);
      //更新 location  获取当前位置
      Api.updateLocation(
          currentLocation["latitude"], currentLocation["longitude"]);
      NearbyModel result = await Api.getNearUsers(getStore(),
          currentLocation["latitude"], currentLocation["longitude"], page);
      pullLoadWidgetControl.needLoadMore = true;
      if (result?.auth_status == -1) {
        //没有token 跳转登录
        NavigatorUtils.goLogin(context);
        return;
      }
    } else {
      print(error);
    }
  }

  @override
  requestLoadMore() async {
    NearbyModel result = await Api.getNearUsers(getStore(),
        currentLocation["latitude"], currentLocation["longitude"], page);
    pullLoadWidgetControl.needLoadMore = true;
    if (result?.auth_status == -1) {
      //没有token 跳转登录
      NavigatorUtils.goLogin(context);
      return;
    } else if (result?.data?.user == null || result?.data?.user?.length == 0) {
      page--;
      pullLoadWidgetControl.needLoadMore = false;
    }
  }

  _renderItem(context, index) {
    NearbyItemModel model = pullLoadWidgetControl.dataList[index];

    return GestureDetector(
      onTap: () => _goUserDetail(context, model.username, model.uid),
      child: Card(
          color: Color(FZColors.cellBlackBg),
          child: new Column(children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  topRight: Radius.circular(4.0)),
              child: FadeInImage.assetNetwork(
                  width: cellWidth,
                  height: cellWidth,
                  fit: BoxFit.cover,
                  placeholder: "static/images/bg.jpg",
                  image: model?.avatar ?? ""),
            ),
            new Expanded(
                child: new Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                  Text(
                    model.username,
                    maxLines: 1,
                    style: TextStyle(color: Color(FZColors.textGray)),
                  ),
                  Text(
                    model.distance,
                    maxLines: 1,
                    style: TextStyle(color: Color(FZColors.textGray)),
                  ),
                ]))
          ])),
    );
  }

  void _goUserDetail(BuildContext context, username, uid) {
    NavigatorUtils.goOtherDetail(context, username, uid);
  }
}
