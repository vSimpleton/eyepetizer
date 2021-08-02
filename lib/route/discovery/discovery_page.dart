import 'package:eyepetizer/config/string.dart';
import 'package:eyepetizer/widget/app_bar.dart';
import 'package:flutter/material.dart';

class DiscoveryPage extends StatefulWidget {
  const DiscoveryPage({Key key}) : super(key: key);

  @override
  _DiscoveryPageState createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: appBar(StringConfig.discovery, showBack: false),
      body: Container(
        alignment: Alignment.center,
        child: Text('我是发现页'),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
