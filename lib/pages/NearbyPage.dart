import 'package:flutter/material.dart';

class NearbyPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _NearbyPageState();

}


class _NearbyPageState extends State<NearbyPage> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    print('_NearbyPageState');
    return new Scaffold(
      appBar:AppBar(
        title: Text("日志"),
      ),
    );
  }

}