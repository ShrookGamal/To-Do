import 'dart:async';

import 'package:flutter/material.dart';
import 'package:to_do/core/utils/assets_manager.dart';
import 'package:to_do/core/utils/colors_manager.dart';

import '../../../core/utils/routes_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, RoutesManager.homeRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: ColorsManager.scaffoldColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AssetsManager.splashLogo),
          ],
        ));
  }
}
