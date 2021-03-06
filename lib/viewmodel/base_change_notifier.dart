import 'package:eyepetizer/widget/loading_state_widget.dart';
import 'package:flutter/material.dart';

class BaseChangeNotifier with ChangeNotifier {
  // 当页面被销毁后不发送通知
  bool _dispose = false;
  ViewState viewState = ViewState.loading;

  @override
  void dispose() {
    super.dispose();
    _dispose = true;
  }

  @override
  void notifyListeners() {
    if (!_dispose) {
      super.notifyListeners();
    }
  }
}
