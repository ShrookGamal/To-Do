import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/colors_manager.dart';

class SettingsTab extends StatefulWidget {
  SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  String selectedTheme = 'Light';

  String selectedLang = 'English';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: REdgeInsets.symmetric(vertical: 60, horizontal: 30),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Theme',
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: ColorsManager.lightBlack),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            padding: REdgeInsets.symmetric(horizontal: 5),
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(color: ColorsManager.blue),
                color: Colors.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedTheme,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: ColorsManager.blue),
                ),
                DropdownButton<String>(
                  underline: Container(
                    color: Colors.transparent,
                  ),
                  items: <String>['Light', 'Dark'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newTheme) {
                    selectedTheme = newTheme!;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 70.h,
          ),
          Text(
            'Language',
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: ColorsManager.lightBlack),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            padding: REdgeInsets.symmetric(horizontal: 5),
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(color: ColorsManager.blue),
                color: Colors.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedLang,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: ColorsManager.blue),
                ),
                DropdownButton<String>(
                  underline: Container(
                    color: Colors.transparent,
                  ),
                  items: <String>['English', 'Arabic'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newLanguage) {
                    selectedLang = newLanguage!;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
