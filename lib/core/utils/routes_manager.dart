import 'package:flutter/material.dart';
import 'package:to_do/presentation/screens/home/home_screen.dart';

import '../../presentation/screens/splash/splash_screen.dart';

class RoutesManager {
  static const String homeRoute = '/home';
  static const String splashRoute = '/splash';

  static Route? router(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        {
          return MaterialPageRoute(builder: (context) => HomeScreen());
        }
      case splashRoute:
        {
          return MaterialPageRoute(builder: (context) => SplashScreen());
        }
    }
  }
}