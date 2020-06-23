package com.qzl.flutter.flutter_framework

import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import org.devio.flutter.splashscreen.SplashScreen

class MainActivity: FlutterActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
    //解决启动白屏的问题
    SplashScreen.show(this,true)
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)
  }
}
