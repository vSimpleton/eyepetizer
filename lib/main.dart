import 'dart:io';

import 'package:eyepetizer/app_init.dart';
import 'package:eyepetizer/http/http_manager.dart';
import 'package:eyepetizer/http/url.dart';
import 'package:eyepetizer/tab_navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
  // 沉浸式状态栏
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 异步UI更新
    return FutureBuilder(
      future: AppInit.hideScreen(),
      builder: (context, snapshot) {
        // HttpManager.getData(Url.feedUrl, headers: Url.httpHeader, success: (result) {
        //   print(result);
        // }, fail: (e) {
        //   print(e);
        // });
        var widget = snapshot.connectionState == ConnectionState.done
            ? TabNavigation()
            : Scaffold(
                body: Center(
                  child: CupertinoActivityIndicator(
                    radius: 15,
                  ),
                ),
              );
        return MaterialAppWidget(widget);
      },
    );
  }
}

class MaterialAppWidget extends StatefulWidget {
  final Widget child;

  MaterialAppWidget(this.child) : super();

  @override
  State<StatefulWidget> createState() => _MaterialAppWidgetState();
}

class _MaterialAppWidgetState extends State<MaterialAppWidget> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "开眼视频",
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => widget.child),
      ],
    );
  }
}
