import 'dart:developer';

import 'package:contacts/database/repository.dart';
import 'package:contacts/pages/bottom_nav.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    log(DateTime.now().toString());
    CrudOperatons().loadContact().then(
      (value) {
        Navigator.pushReplacement(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(
              builder: (context) => const BottomNavScreen(),
            ));
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Icon(
        Icons.contact_page,
        size: 40,
      )),
    );
  }
}
