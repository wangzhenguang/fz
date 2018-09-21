import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavigationWidget extends StatefulWidget {
  final List<String> titles;

  final List<String> tabBarTitles;

  final List<List<Widget>> tabImages;
  final List<Widget> actions;
  bool centerTitle = true;

  List<Widget> body;

  int tabIndex;
  Color tabTextNormal = Colors.grey;
  Color tabTextSelected = Colors.blue;
  Color themeColor;
  Color titleColor;

  @override
  State<StatefulWidget> createState() => _BottomNavigationWidgetState();

  BottomNavigationWidget(
      {@required this.tabBarTitles,
      @required this.tabImages,
      @required this.body,
      @required this.titles,
      this.actions,
      this.tabIndex = 0,
      this.tabTextNormal,
      this.tabTextSelected,
      this.themeColor,
      this.centerTitle});
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: widget.themeColor ?? Theme.of(context).primaryColor),
      home: Scaffold(
        appBar: AppBar(
          actions: widget.actions,
          centerTitle: widget.centerTitle,
          title: Text(
            widget.titles[widget.tabIndex],
            style: TextStyle(color: widget.titleColor ?? Colors.white),
          ),
        ),
        body: IndexedStack(
          children: widget.body,
          index: widget.tabIndex,
        ),
        bottomNavigationBar: _renderBottomNavigationBar(),
      ),
    );
  }

  _renderBottomNavigationBar() {
    var widgets = List<BottomNavigationBarItem>();
    for (var i = 0; i < widget.tabImages.length; i++) {
      widgets.add(
          BottomNavigationBarItem(icon: getTabIcon(i), title: getTabTitle(i)));
    }

    var tabBar = new CupertinoTabBar(
      currentIndex: widget.tabIndex,
      items: widgets,
      onTap: (index) {
        setState(() {
          widget.tabIndex = index;
        });
      },
    );
    return tabBar;
  }

  TextStyle getTabTextStyle(int curIndex) {
    if (curIndex == widget.tabIndex) {
      return new TextStyle(color: widget.tabTextSelected);
    }
    return new TextStyle(color: widget.tabTextNormal);
  }

  Widget getTabIcon(int curIndex) {
    if (curIndex == widget.tabIndex) {
      return widget.tabImages[curIndex][1];
    }
    return widget.tabImages[curIndex][0];
  }

  Text getTabTitle(int curIndex) {
    return new Text(widget.titles[curIndex], style: getTabTextStyle(curIndex));
  }
}
