import 'package:eyepetizer/config/string.dart';
import 'package:eyepetizer/page/category/category_page.dart';
import 'package:eyepetizer/page/home/home_page.dart';
import 'package:eyepetizer/utils/assets_util.dart';
import 'package:eyepetizer/utils/toast_util.dart';
import 'package:eyepetizer/viewmodel/main_view_model.dart';
import 'package:eyepetizer/widget/provider_widget.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var lastTime;
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: ProviderWidget<MainViewModel>(
          viewModel: MainViewModel(),
          builder: (context, viewModel, child) {
            return Scaffold(
              body: _pageView(viewModel),
              bottomNavigationBar: _bottomNavigationBar(viewModel),
            );
          },
        ),
        onWillPop: _onWillPop);
  }

  Widget _pageView(MainViewModel viewModel) {
    return PageView(
      controller: _pageController,
      onPageChanged: (index) {
        viewModel.changeBottomTabIndex(index);
      },
      children: [
        HomePage(),
        CategoryPage(),
      ],
    );
  }

  Widget _bottomNavigationBar(MainViewModel viewModel) {
    return BottomNavigationBar(
      items: _navItems(),
      currentIndex: viewModel.currentIndex,
      onTap: (value) {
        if (viewModel.currentIndex != value) {
          _pageController.jumpToPage(value);
          viewModel.changeBottomTabIndex(value);
        }
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Color(0xff000000),
      unselectedItemColor: Color(0xff9a9a9a),
      selectedFontSize: 13,
      unselectedFontSize: 13,
    );
  }

  List<BottomNavigationBarItem> _navItems() {
    return [
      BottomNavigationBarItem(
          icon: getTabImageAsset("ic_home_normal", width: 24),
          activeIcon: getTabImageAsset("ic_home_selected", width: 24),
          label: "推荐"),
      BottomNavigationBarItem(
          icon: getTabImageAsset("ic_discovery_normal", width: 24),
          activeIcon: getTabImageAsset("ic_discovery_selected", width: 24),
          label: "分类"),
    ];
  }

  /// 防误触返回键
  Future<bool> _onWillPop() async {
    if (lastTime == null ||
        DateTime.now().difference(lastTime) > Duration(seconds: 2)) {
      lastTime = DateTime.now();
      Toast.showToast(exitTips);
      return false;
    } else {
      return true;
    }
  }
}
