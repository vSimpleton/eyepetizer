import 'package:flutter/material.dart';

appBar(String title,
    {bool showBack = false,
    List<Widget> actions,
    PreferredSizeWidget bottom}) {
  return AppBar(
    title: Text(
      title,
      style: TextStyle(
          fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
    ),
    centerTitle: true,
    brightness: Brightness.light,
    elevation: 3,
    backgroundColor: Colors.white,
    leading: showBack
        ? BackButton(
            color: Colors.black,
          )
        : null,
    actions: actions,
    bottom: bottom,
  );
}
