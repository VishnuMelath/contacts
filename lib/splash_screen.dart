import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CountryCodePicker(
          showDropDownButton: true,
          showCountryOnly: true,
          showFlag: true,
          showFlagDialog: true,
          hideMainText: true,
          showFlagMain: true,
          initialSelection: 'in',
          onChanged: (value) {
            log(value.code.toString());
            log(value.dialCode.toString());
          },
          // boxDecoration: BoxDecoration(border: Border.all(color: Colors.black)),
        ),
      ),
    );
  }
}
