import 'package:flutter/material.dart';
import 'package:fz/model/feeds/FeedsModel.dart';
import 'package:fz/model/nearby/NearbyModel.dart';
import 'package:fz/model/photo/PhotoModel.dart';
import 'package:fz/redux/FeedsRedux.dart';
import 'package:fz/redux/PhotoRedux.dart';
import 'package:fz/redux/NearbyRedux.dart';
import 'package:fz/redux/LogRedux.dart';
import 'package:fz/style/FZColors.dart';

class FZState {
  ThemeData themeData = FZColors.themeData;
  List<FeedsModel> feeds = new List();
  List<PhotoItemModel> photos = new List();
  List<NearbyItemModel> nearbyModels = new List();
  List<FeedsModel> blogModels = new List();

  ///用this.feeds 外部创建没有默认值 不知道啥原因
  FZState(
      {ThemeData themeData,
      this.feeds,
      this.photos,
      this.nearbyModels,
      this.blogModels});
}

FZState appReducer(FZState state, action) {
  return FZState(
      feeds: FeedsReducer(state.feeds, action),
      photos: PhotoReducer(state.photos, action),
      nearbyModels: NearbyReducer(state.nearbyModels, action),
      blogModels: LogReducer(state.blogModels, action));
}
