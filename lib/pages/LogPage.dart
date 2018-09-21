import 'package:flutter/material.dart';

class LogPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _LogPageState();
}


class _LogPageState extends State<LogPage> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    print('LogPage');
    return new Scaffold(
      appBar:AppBar(
        title: Text("日志"),
      ),
    );
  }

}