import 'package:eyepetizer/widget/loading_state_widget.dart';
import 'package:flutter/material.dart';

class BaseChangeNotifier with ChangeNotifier {

  bool _dispose = false;
  var viewState = ViewState.loading;

  @override
  void dispose() {
    super.dispose();
    _dispose = true;
  }

  @override
  void notifyListeners() {
    if(!_dispose) {
      super.notifyListeners();
    }
  }

}