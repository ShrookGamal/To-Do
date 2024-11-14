import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors_manager.dart';

class AppTextStyles {
  static TextStyle welcomeText(bool isLight) => GoogleFonts.poppins(
      decoration: TextDecoration.none,
      fontWeight: FontWeight.w500,
      fontSize: 14,
      color: isLight ? ColorsManager.blue : Colors.white);

  static TextStyle appBarTextStyle(bool isLight) => TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 22,
      color: isLight ? Colors.white : ColorsManager.darkScaffold);

  static TextStyle taskSheetTitleTextStyle(bool isLight) => TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 18,
      color: isLight ? ColorsManager.lightBlack : Colors.white);

  static TextStyle hintTextStyle(bool isLight) => TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: isLight ? ColorsManager.hintColor : Colors.white);

  static TextStyle dateLabelTextStyle(bool isLight) => TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: isLight ? ColorsManager.lightBlack : Colors.white);
  static TextStyle elevatedButtonText = const TextStyle(
      fontWeight: FontWeight.w500, fontSize: 20, color: Colors.white);
  static TextStyle taskTitle = const TextStyle(
      fontWeight: FontWeight.w600, fontSize: 16, color: ColorsManager.blue);

  static TextStyle taskDescription(bool isLight) => TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: isLight ? ColorsManager.black : Colors.white,
        decoration: TextDecoration.none,
      );
  static TextStyle loginText = const TextStyle(
      fontWeight: FontWeight.w700, fontSize: 25, color: Colors.white);
  static TextStyle signup = const TextStyle(
      fontWeight: FontWeight.w700, fontSize: 16, color: ColorsManager.blue);

  static TextStyle editTitle(bool isLight) => GoogleFonts.poppins(
      fontWeight: FontWeight.w700,
      fontSize: 18,
      color: isLight ? ColorsManager.black : Colors.white);
  static TextStyle doneTaskTitle = GoogleFonts.poppins(
      fontWeight: FontWeight.w600, fontSize: 16, color: ColorsManager.green);
  static TextStyle doneTaskDes = GoogleFonts.poppins(
      fontWeight: FontWeight.w500, fontSize: 14, color: ColorsManager.green);
}
