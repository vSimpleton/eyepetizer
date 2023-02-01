import 'dart:async';

import 'package:eyepetizer/page/main_page.dart';
import 'package:eyepetizer/utils/route_util.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer(Duration(milliseconds: 2500), () {
      // Navigator.pop(context);
      // toPage(MainPage());

      // fixme 使用上述方法会造成VideoDetailPage页面的跳转问题（一脸懵逼🤔），后续再研究
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MainPage()), (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "images/landing_lang.png",
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Image.asset("images/landing_image.png", width: 150,),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 40,
            child: Image.asset(
              "images/landing_bottom.png",
              height: 60,
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
