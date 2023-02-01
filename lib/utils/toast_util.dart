import 'package:flutter/services.dart';

class Toast {

  static const MethodChannel _channel = const MethodChannel('toast_plugin');

  static Future<void> showToast(String message) async {
    await _channel.invokeMethod("showToast", message);
  }

}