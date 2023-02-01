package io.github.eyepetizer

import android.content.Context
import android.widget.Toast
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

/**
 * NAME: vSimpleton
 * DATE: 2021/8/20
 * DESC: ToastPlugin
 */

class ToastPlugin(context: Context) : FlutterPlugin, MethodChannel.MethodCallHandler {

    private lateinit var methodChannel: MethodChannel
    private var mContext: Context = context

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        methodChannel = MethodChannel(binding.binaryMessenger, "toast_plugin")
        methodChannel.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        methodChannel.setMethodCallHandler(null)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "showToast" -> {
                val message = call.arguments as String
                Toast.makeText(mContext, message, Toast.LENGTH_SHORT).show()
            }
            else -> result.notImplemented()
        }
    }

}