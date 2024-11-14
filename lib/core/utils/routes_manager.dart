import 'package:flutter/material.dart';
import 'package:to_do/presentation/screens/home/home_screen.dart';
import 'package:to_do/presentation/screens/welcome/welcome.dart';

import '../../presentation/screens/splash/splash_screen.dart';
import '../../presentation/screens/welcome/register.dart';

class RoutesManager {
  static const String homeRoute = '/home';
  static const String splashRoute = '/splash';
  static const String welcomeScreen = '/welcome';
  static const String loginScreen = '/login';
  static const String registerScreen = '/register';
  static const String editTask = '/edit';

  static Route? router(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        {
          return MaterialPageRoute(builder: (context) => HomeScreen());
        }
      case splashRoute:
        {
          return MaterialPageRoute(builder: (context) => const SplashScreen());
        }
      case welcomeScreen:
        {
          return MaterialPageRoute(builder: (context) => const WelcomeScreen());
        }
      case registerScreen:
        {
          return MaterialPageRoute(builder: (context) => Register());
        }
    }
  }
}