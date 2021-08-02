import 'package:eyepetizer/config/string.dart';
import 'package:eyepetizer/widget/app_bar.dart';
import 'package:flutter/material.dart';

class HotPage extends StatefulWidget {
  const HotPage({Key key}) : super(key: key);

  @override
  _HotPageState createState() => _HotPageState();
}

class _HotPageState extends State<HotPage> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: appBar(StringConfig.hot, showBack: false),
      body: Container(
        alignment: Alignment.center,
        child: Text('我是热门页'),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
