import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/core/utils/colors_manager.dart';

import '../../../../core/utils/text_styles.dart';
import '../../../../providers/settings_provider.dart';

typedef Validator = String? Function(String?);

class CustomField extends StatelessWidget {
  CustomField({
    super.key,
    required this.hint,
    required this.controller,
    required this.validator,
    this.isSecured = false,
    this.keyBoardType = TextInputType.text,
    this.icon,
  });

  String hint;
  TextEditingController controller;

  Validator validator;

  TextInputType keyBoardType;
  bool isSecured;
  Icon? icon;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    bool isLight = provider.isLight();
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: isSecured,
      keyboardType: keyBoardType,
      decoration: InputDecoration(
        filled: true,
        fillColor: ColorsManager.scaffoldColor,
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        errorBorder:
            const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        hintText: hint,
        hintStyle: AppTextStyles.hintTextStyle(isLight),
        suffixIcon: icon,
      ),
    );
  }
}
