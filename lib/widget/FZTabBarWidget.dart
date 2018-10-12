import 'package:flutter/material.dart';
import 'package:fz/style/FZColors.dart';

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
  final ValueChanged<int> onTap;

  final Widget drawer;
  final List<Widget> actions;
  final List<BottomNavigationBarItem> bottomNavigationBarItem;
  final bool centerTitle;

  FZTabBarWidget(
      {Key key,
      @required this.type,
      this.tabItems,
      this.indicatorColor,
      this.tabViews,
      this.floatingActionButton,
      this.title,
      this.onPageChanged,
      this.drawer,
      this.bottomNavigationBarItem,
      this.pageController,
      this.actions,
      this.centerTitle = true,
      this.onTap});

  @override
  State<StatefulWidget> createState() {
    return FZTabBarWidgetState();
  }
}

class FZTabBarWidgetState extends State<FZTabBarWidget>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  int _currentIndex = 0;

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
          backgroundColor: Colors.black,
          title: widget.title,
          actions: widget.actions,
          centerTitle: widget.centerTitle,
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
//      backgroundColor: Color(FZColors.lineBlack),
      appBar: new AppBar(
//        backgroundColor: Color(FZColors.primaryValue),
        title: widget.title,
        actions: widget.actions,
        centerTitle: widget.centerTitle,
      ),
      body: Center(
        child: widget.tabViews[_currentIndex],
      ),

//      new TabBarView(
//        children: widget.tabViews,
//        controller: _tabController,
//      ),
      bottomNavigationBar: new Theme(
        data: Theme.of(context)
            .copyWith(canvasColor: Color(FZColors.appBarColor)),
        child: new BottomNavigationBar(
          items: widget.bottomNavigationBarItem,
//          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (index) {
            _tabController?.animateTo(index);
            widget.onPageChanged?.call(index);
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }

  pageChange(index) => index;
}
