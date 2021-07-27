import 'package:flutter_splash_screen/flutter_splash_screen.dart';

class AppInit {

  AppInit._();

  static Future<void> hideScreen() async {
    Future.delayed(Duration(milliseconds: 2000), () {
      FlutterSplashScreen.hide();
    });
  }

}
