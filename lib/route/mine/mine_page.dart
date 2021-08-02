import 'package:eyepetizer/config/string.dart';
import 'package:eyepetizer/widget/app_bar.dart';
import 'package:flutter/material.dart';

class MinePage extends StatefulWidget {
  const MinePage({Key key}) : super(key: key);

  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> with AutomaticKeepAliveClientMixin{

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: appBar(StringConfig.mine, showBack: false),
      body: Container(
        alignment: Alignment.center,
        child: Text('我是我的页'),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
