import 'package:flutter/cupertino.dart';

Widget getTabImageAsset(String img, {double width = 24, double height = 24}) {
  return Image.asset("images/$img.png", width: width, height: height,);
}
