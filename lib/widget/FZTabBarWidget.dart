import 'package:flutter/material.dart';

class FZTabBarWidget extends StatefulWidget {
  ///底部模式type
  static const int BOTTOM_TAB = 1;

  ///顶部模式type
  static const int TOP_TAB = 2;

  final int type;

  final List<Widget> tabItems;

  final Color indicatorColor;

  final PageController pageController;

  final List<Widget> tabViews;

  final Widget floatingActionButton;

  final Widget title;

  final ValueChanged<int> onPageChanged;

  final Widget drawer;
  final List<BottomNavigationBarItem> bottomNavigationBarItem;

  FZTabBarWidget({
    Key key,
    @required this.type,
    this.tabItems,
    this.indicatorColor,
    this.tabViews,
    this.floatingActionButton,
    this.title,
    this.onPageChanged,
    this.drawer,
    this.bottomNavigationBarItem,
    this.pageController
  });

  @override
  State<StatefulWidget> createState() {
    return FZTabBarWidgetState();
  }
}

class FZTabBarWidgetState extends State<FZTabBarWidget>
    with SingleTickerProviderStateMixin {
  TabController _tabController;


  @override
  void initState() {
    super.initState();
    _tabController =
        new TabController(length: widget.tabViews.length, vsync: this);
  }

  @override
  void dispose() {
    // 释放控制器
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type == FZTabBarWidget.TOP_TAB) {
      return Scaffold(
        appBar: new AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: widget.title,
          bottom: new TabBar(
            tabs: widget.tabItems,
            controller: _tabController,
            indicatorColor: widget.indicatorColor,
          ),
        ),
        body: PageView(
          controller: widget.pageController,
          children: widget.tabViews,
          onPageChanged: (index) {
            _tabController.animateTo(index);
            widget.onPageChanged?.call(index);
          },
        ),
      );
    }

    //底部
    return new Scaffold(
      drawer: widget.drawer,
      appBar: new AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: widget.title,
      ),
      body: new TabBarView(
        children: widget.tabViews,
        controller: _tabController,
      ),
      bottomNavigationBar: new Material(
        color: Theme.of(context).primaryColor,
        child: new BottomNavigationBar(
          items: widget.bottomNavigationBarItem,
          type: BottomNavigationBarType.fixed,
          currentIndex: 0,
          onTap: (index) {
            _tabController?.animateTo(index);
            widget.onPageChanged?.call(index);
          },
        ),
      ),
    );
  }
}
