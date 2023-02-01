import 'dart:io';

import 'package:eyepetizer/page/splash_page.dart';
import 'package:eyepetizer/page/video_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: '开眼视频',
        initialRoute: '/',
        getPages: [
          GetPage(name: '/', page: () => SplashPage()),
          GetPage(name: '/detail', page: () => VideoDetailPage()),
        ]
    );
  }
}
