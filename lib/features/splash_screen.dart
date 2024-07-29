import "dart:async";

import "package:flutter/material.dart";
import "package:get/get_core/src/get_main.dart";
import "package:get/get_navigation/get_navigation.dart";

import "package:girdhari/features/product/screens/stock_record_screen.dart";

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
        const Duration(seconds: 3),
       
        () => Get.to(const StockRecordScreen()));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Padding(
          padding: EdgeInsets.all(18.0),
          child: Image(image: AssetImage('assets/images/png/splash_logo.png'))),
    ));
  }
}
