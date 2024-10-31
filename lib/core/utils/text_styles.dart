import 'package:flutter/material.dart';

import 'colors_manager.dart';

class AppTextStyles {
  static TextStyle appBarTextStyle =
      TextStyle(fontWeight: FontWeight.w700, fontSize: 22, color: Colors.white);
  static TextStyle taskSheetTitleTextStyle = TextStyle(
      fontWeight: FontWeight.w700, fontSize: 18, color: ColorsManager.black);
  static TextStyle hintTextStyle = TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: ColorsManager.hintColor);
  static TextStyle DateLabelTextStyle = TextStyle(
      fontWeight: FontWeight.w400, fontSize: 18, color: ColorsManager.black);
  static TextStyle elevatedButtonText =
      TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: Colors.white);
  static TextStyle taskTitle = TextStyle(
      fontWeight: FontWeight.w700, fontSize: 18, color: ColorsManager.blue);
  static TextStyle taskDescription = TextStyle(
      fontWeight: FontWeight.w700, fontSize: 16, color: ColorsManager.black);
}
