package io.github.eyepetizer

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {

    private val mToastPlugin by lazy { ToastPlugin(this) }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)


        flutterEngine?.dartExecutor?.binaryMessenger?.let {
            MethodChannel(it, "toast_plugin").setMethodCallHandler(mToastPlugin)
        }
    }

}
