import 'package:flutter/material.dart';

import '../../core/utils/colors_manager.dart';

class AppTheme {
  static ThemeData light = ThemeData(
      colorScheme: ColorScheme.fromSeed(
          seedColor: ColorsManager.blue,
          primary: ColorsManager.blue,
          onPrimary: Colors.white),
      appBarTheme: AppBarTheme(
          elevation: 0,
          shadowColor: Colors.transparent,
          backgroundColor: ColorsManager.blue,
          titleTextStyle: TextStyle(
              fontWeight: FontWeight.w700, fontSize: 22, color: Colors.white)),
      scaffoldBackgroundColor: ColorsManager.scaffoldColor,
      bottomAppBarTheme: const BottomAppBarTheme(
        color: Colors.white,
        shape: CircularNotchedRectangle(),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: ColorsManager.blue,
          unselectedItemColor: ColorsManager.gray),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: ColorsManager.blue,
          shape: StadiumBorder(side: BorderSide(color: Colors.white, width: 4)),
          iconSize: 30),
      bottomSheetTheme: const BottomSheetThemeData(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))),
          backgroundColor: Colors.white),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(ColorsManager.blue),
        //padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(20)),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
        elevation: MaterialStateProperty.all<double>(10),
      )));
  static ThemeData dark = ThemeData(
      colorScheme: ColorScheme.fromSeed(
          seedColor: ColorsManager.blue,
          primary: ColorsManager.blue,
          onPrimary: ColorsManager.darkScaffold),
      appBarTheme: const AppBarTheme(
          elevation: 0,
          shadowColor: Colors.transparent,
          backgroundColor: ColorsManager.blue,
          titleTextStyle: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 22,
              color: ColorsManager.darkScaffold)),
      scaffoldBackgroundColor: ColorsManager.darkScaffold,
      bottomAppBarTheme: const BottomAppBarTheme(
        color: ColorsManager.darkBlack,
        shape: CircularNotchedRectangle(),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: ColorsManager.blue,
          unselectedItemColor: ColorsManager.gray),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: ColorsManager.blue,
          shape: StadiumBorder(
              side: BorderSide(color: ColorsManager.darkScaffold, width: 4)),
          iconSize: 30),
      bottomSheetTheme: const BottomSheetThemeData(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))),
          backgroundColor: ColorsManager.darkBlack),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(ColorsManager.blue),
        //padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(20)),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
        elevation: MaterialStateProperty.all<double>(10),
      )));
}
