import 'dart:io';

import 'package:eyepetizer/app_init.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
  // 沉浸式状态栏
  if(Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppInit.hideScreen();
    return Container(
      color: Colors.blue,
    );
  }
}