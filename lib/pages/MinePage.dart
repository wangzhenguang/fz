import 'package:flutter/material.dart';
import 'package:fz/net/NetEngine.dart';
import 'package:fz/net/service/Api.dart';
import 'package:fz/util/LocalStorage.dart';

class MinePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _MinePageState();

}


class _MinePageState extends State<MinePage> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    print('MinePage');
    return new Scaffold(
      appBar:AppBar(
        title: Text("日志"),
      ),
    );
  }

}
