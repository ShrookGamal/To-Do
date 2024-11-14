import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../core/utils/colors_manager.dart';
import '../../../../../providers/settings_provider.dart';

class SettingsTab extends StatefulWidget {
  SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  late String selectedTheme;

  late String selectedLang;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    selectedTheme = AppLocalizations.of(context)!.light;
    selectedLang = AppLocalizations.of(context)!.english;
  }

  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //    selectedTheme = AppLocalizations.of(context)!.light;
  //    selectedLang = AppLocalizations.of(context)!.english;
  // }
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    return Container(
      margin: REdgeInsets.symmetric(vertical: 60, horizontal: 30),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.theme,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: provider.isLight()
                    ? ColorsManager.lightBlack
                    : Colors.white),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            padding: REdgeInsets.symmetric(horizontal: 5),
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(color: ColorsManager.blue),
                color: provider.isLight()
                    ? Colors.white
                    : ColorsManager.darkBlack),
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
                  items: <String>[
                    AppLocalizations.of(context)!.light,
                    AppLocalizations.of(context)!.dark
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newTheme) {
                    selectedTheme = newTheme!;
                    if (selectedTheme == AppLocalizations.of(context)!.light) {
                      provider.changeAppTheme(ThemeMode.light);
                    } else {
                      provider.changeAppTheme(ThemeMode.dark);
                    }
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
            AppLocalizations.of(context)!.language,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: provider.isLight()
                    ? ColorsManager.lightBlack
                    : Colors.white),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            padding: REdgeInsets.symmetric(horizontal: 5),
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(color: ColorsManager.blue),
                color: provider.isLight()
                    ? Colors.white
                    : ColorsManager.darkBlack),
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
                  items: <String>[
                    AppLocalizations.of(context)!.english,
                    AppLocalizations.of(context)!.arabic
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newLanguage) {
                    selectedLang = newLanguage!;
                    if (selectedLang == AppLocalizations.of(context)!.english) {
                      provider.changeAppLang('en');
                    } else {
                      provider.changeAppLang('ar');
                    }
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
