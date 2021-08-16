import 'package:eyepetizer/config/color.dart';
import 'package:flutter/material.dart';

TabBar tabBar({
  TabController controller,
  List<Widget> tabs,
  ValueChanged<int> onTap,
  double fontSize = 14,
  // 当前选中的标签字体颜色
  Color labelColor = Colors.black,
  // 未选中的标签字体颜色
  Color unselectedLabelColor = ColorConfig.hitTextColor,
  // 下划线的颜色
  Color indicatorColor = Colors.black,
  // 下划线的大小
  TabBarIndicatorSize indicatorSize = TabBarIndicatorSize.label,
}) {
  return TabBar(
    controller: controller,
    tabs: tabs,
    onTap: onTap,
    labelColor: labelColor,
    unselectedLabelColor: unselectedLabelColor,
    labelStyle: TextStyle(fontSize: fontSize),
    unselectedLabelStyle: TextStyle(fontSize: fontSize),
    indicatorColor: indicatorColor,
    indicatorSize: indicatorSize,
  );
}
