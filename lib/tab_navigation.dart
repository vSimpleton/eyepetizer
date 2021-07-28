import 'package:eyepetizer/config/string.dart';
import 'package:eyepetizer/utils/toast_util.dart';
import 'package:flutter/material.dart';

class TabNavigation extends StatefulWidget {
  const TabNavigation({Key? key}) : super(key: key);

  @override
  _TabNavigationState createState() => _TabNavigationState();
}

class _TabNavigationState extends State<TabNavigation> {
  var lastTime;
  var _currentIndex = 0;

  var _currentBody = Container(
    color: Colors.blue,
  );

  @override
  Widget build(BuildContext context) {
    final _bottomNavigationBar = BottomNavigationBar(
      items: _navItems(),
      currentIndex: _currentIndex,
      onTap: _onTap,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Color(0xff000000),
      unselectedItemColor: Color(0xff9a9a9a),
      selectedFontSize: 13,
      unselectedFontSize: 13,
    );

    return WillPopScope(
        child: Scaffold(
          body: _currentBody,
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
        icon: Image.asset(normalIcon, width: 24, height: 24,),
        activeIcon: Image.asset(selectIcon, width: 24, height: 24,),
        label: title);
  }

  /// 防误触返回键
  Future<bool> _onWillPop() async {
    if (lastTime == null || DateTime.now().difference(lastTime) > Duration(seconds: 2)) {
      lastTime = DateTime.now();
      ToastUtil.showToast(StringConfig.exitTips);
      return false;
    } else {
      return true;
    }
  }

  _onTap(int index) {
    switch(index) {
      case 0:
        _currentBody = Container(
          color: Colors.blue,
        );
        break;
      case 1:
        _currentBody = Container(
          color: Colors.green,
        );
        break;
      case 2:
        _currentBody = Container(
          color: Colors.yellow,
        );
        break;
      case 3:
        _currentBody = Container(
          color: Colors.pink,
        );
        break;
    }
    setState(() {
      _currentIndex = index;
    });
  }
}
