import 'package:flutter/material.dart';
import 'package:to_do/core/utils/routes_manager.dart';

import '../config/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: RoutesManager.router,
      initialRoute: RoutesManager.splashRoute,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.light,
    );
  }
}
