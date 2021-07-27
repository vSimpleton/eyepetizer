package com.miya.eyepetizer

import android.os.Bundle
import androidx.annotation.Nullable
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import org.devio.flutter.splashscreen.SplashScreen

class MainActivity: FlutterActivity() {

    override fun onCreate(@Nullable savedInstanceState: Bundle?) {
        SplashScreen.show(this, true)
        super.onCreate(savedInstanceState)
    }

}
