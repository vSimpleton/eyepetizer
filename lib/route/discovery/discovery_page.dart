import 'package:eyepetizer/config/string.dart';
import 'package:eyepetizer/route/discovery/category_page.dart';
import 'package:eyepetizer/route/discovery/follow_page.dart';
import 'package:eyepetizer/route/discovery/topic_page.dart';
import 'package:eyepetizer/widget/app_bar.dart';
import 'package:eyepetizer/widget/tab_bar.dart';
import 'package:flutter/material.dart';

const TAB_LABEL = ['关注', '分类', '专题', '资讯', '推荐'];

class DiscoveryPage extends StatefulWidget {
  const DiscoveryPage({Key key}) : super(key: key);

  @override
  _DiscoveryPageState createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    // vsync:ticker 驱动动画，每次屏幕刷新都会调用TickerCallback，
    _tabController = TabController(length: TAB_LABEL.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
          brightness: Brightness.light,
          elevation: 3,
          backgroundColor: Colors.white,
          flexibleSpace: SafeArea(
            child: tabBar(
                controller: _tabController,
                tabs: TAB_LABEL
                    .map((label) => Tab(
                          text: label,
                        ))
                    .toList()),
          )),
      body: TabBarView(
        controller: _tabController,
        children: [
          FollowPage(),
          CategoryPage(),
          TopicPage(),
          Container(color: Colors.yellow),
          Container(color: Colors.pink),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
