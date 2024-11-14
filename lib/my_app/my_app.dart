import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:to_do/core/utils/routes_manager.dart';
import 'package:to_do/providers/settings_provider.dart';

import '../config/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    return ScreenUtilInit(
      designSize: const Size(412, 870),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: const [
          Locale('ar'),
          Locale('en'),
        ],
        locale: Locale(provider.currentLang),
        onGenerateRoute: RoutesManager.router,
        initialRoute: RoutesManager.splashRoute,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: provider.currentTheme,
      ),
    );
  }
}
