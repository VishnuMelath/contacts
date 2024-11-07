package com.example.contacts

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.Intent
import android.net.Uri

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.callService"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "makePhoneCall") {
                val number = call.argument<String>("number")
                if (number != null) {
                    makePhoneCall(number)
                    result.success(null)
                } else {
                    result.error("INVALID_NUMBER", "Phone number is null", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun makePhoneCall(phoneNumber: String) {
        val intent = Intent(Intent.ACTION_CALL)
        intent.data = Uri.parse("tel:$phoneNumber")
        startActivity(intent)
    }
}
