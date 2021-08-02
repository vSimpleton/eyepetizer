import 'package:eyepetizer/config/string.dart';
import 'package:eyepetizer/route/home_body_page.dart';
import 'package:eyepetizer/widget/app_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

/// AutomaticKeepAliveClientMixin：切换tab后保留tab的状态，避免initState()方法重复调用
/// 1. 需重写wantKeepAlive并返回true
/// 2. 必须调用super.build(context)
class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: appBar(
        StringConfig.home,
        showBack: false,
      ),
      body: HomeBodyPage(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
