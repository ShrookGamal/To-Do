import 'package:flutter/material.dart';

import 'colors_manager.dart';

class AppTextStyles {
  static TextStyle appBarTextStyle = const TextStyle(
      fontWeight: FontWeight.w700, fontSize: 22, color: Colors.white);
  static TextStyle taskSheetTitleTextStyle = const TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 18,
      color: ColorsManager.lightBlack);
  static TextStyle hintTextStyle = const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: ColorsManager.hintColor);
  static TextStyle dateLabelTextStyle = const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: ColorsManager.lightBlack);
  static TextStyle elevatedButtonText = const TextStyle(
      fontWeight: FontWeight.w500, fontSize: 20, color: Colors.white);
  static TextStyle taskTitle = const TextStyle(
      fontWeight: FontWeight.w600, fontSize: 16, color: ColorsManager.blue);
  static TextStyle taskDescription = const TextStyle(
      fontWeight: FontWeight.w500, fontSize: 14, color: ColorsManager.black);
}
