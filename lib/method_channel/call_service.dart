// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:contacts/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class CallService {
  static const platform = MethodChannel('com.example.callService');

  Future<void> makePhoneCall(String phoneNumber, BuildContext context) async {
    PermissionStatus status = await Permission.phone.status;
    if (!status.isGranted) {
      status = await Permission.phone.request();
    }

    if (status.isGranted) {
      try {
        await platform.invokeMethod('makePhoneCall', {"number": phoneNumber});
      } on PlatformException catch (e) {
        log("Failed to make phone call: '${e.message}'.");
        showContactDeletedSnackbar(
            context, '', 'Something went wrong please try again.');
      }
    } else {
      log("Phone call permission denied.");
      showContactDeletedSnackbar(
          context, '', 'App doesn\'t have permission to make calls.');
    }
  }
}
