import 'package:eyepetizer/config/string.dart';
import 'package:eyepetizer/route/home_page.dart';
import 'package:eyepetizer/utils/toast_util.dart';
import 'package:eyepetizer/viewmodel/tab_navigation_viewmodel.dart';
import 'package:eyepetizer/widget/provider_widget.dart';
import 'package:flutter/material.dart';

class TabNavigation extends StatefulWidget {
  const TabNavigation({Key key}) : super(key: key);

  @override
  _TabNavigationState createState() => _TabNavigationState();
}

class _TabNavigationState extends State<TabNavigation> {
  var lastTime;

  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final _bottomNavigationBar = ProviderWidget<TabNavigationViewModel>(
      model: TabNavigationViewModel(),
      builder: (context, model, child) {
        return BottomNavigationBar(
          items: _navItems(),
          currentIndex: model.currentIndex,
          onTap: (value) {
            if(model.currentIndex != value) {
              _pageController.jumpToPage(value);
              model.changeBottomTabIndex(value);
            }
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color(0xff000000),
          unselectedItemColor: Color(0xff9a9a9a),
          selectedFontSize: 13,
          unselectedFontSize: 13,
        );
      },
    );

    return WillPopScope(
        child: Scaffold(
          body: PageView(
            controller: _pageController,
            children: [
              HomePage(),
              Container(color: Colors.green,),
              Container(color: Colors.yellow,),
              Container(color: Colors.pink,),
            ],
          ),
          bottomNavigationBar: _bottomNavigationBar,
        ),
        onWillPop: _onWillPop);
  }

  /// NavigationItem
  List<BottomNavigationBarItem> _navItems() {
    return [
      _bottomItem(StringConfig.home, 'images/ic_home_normal.png',
          'images/ic_home_selected.png'),
      _bottomItem(StringConfig.discovery, 'images/ic_discovery_normal.png',
          'images/ic_discovery_selected.png'),
      _bottomItem(StringConfig.hot, 'images/ic_hot_normal.png',
          'images/ic_hot_selected.png'),
      _bottomItem(StringConfig.mine, 'images/ic_mine_normal.png',
          'images/ic_mine_selected.png'),
    ];
  }

  _bottomItem(String title, String normalIcon, String selectIcon) {
    return BottomNavigationBarItem(
        icon: Image.asset(
          normalIcon,
          width: 24,
          height: 24,
        ),
        activeIcon: Image.asset(
          selectIcon,
          width: 24,
          height: 24,
        ),
        label: title);
  }

  /// 防误触返回键
  Future<bool> _onWillPop() async {
    if (lastTime == null ||
        DateTime.now().difference(lastTime) > Duration(seconds: 2)) {
      lastTime = DateTime.now();
      ToastUtil.showToast(StringConfig.exitTips);
      return false;
    } else {
      return true;
    }

  }
}
