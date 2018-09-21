import 'package:flutter/material.dart';
import 'package:fz/model/FeedsModel.dart';
import 'package:fz/model/photo/PhotoModel.dart';
import 'package:fz/redux/FeedsRedux.dart';
import 'package:fz/redux/PhotoRedux.dart';

class FZState {
  ThemeData themeData;

  List<FeedsModel> feeds = new List();
  List<PhotoItemModel> photos = new List();

  FZState({this.themeData, this.feeds, this.photos});
}

FZState appReducer(FZState state, action) {
  return FZState(
      feeds: FeedsReducer(state.feeds, action),
      photos: PhotoReducer(state.photos, action));
}
