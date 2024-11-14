import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:to_do/core/utils/assets_manager.dart';
import 'package:to_do/core/utils/text_styles.dart';
import 'package:to_do/presentation/screens/welcome/login.dart';
import 'package:to_do/presentation/screens/welcome/register.dart';

import '../../../core/utils/colors_manager.dart';
import '../../../providers/settings_provider.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    bool isLight = provider.isLight();
    return Container(
        padding: REdgeInsets.all(20),
        color: provider.isLight() ? Colors.white : ColorsManager.darkScaffold,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(AssetsManager.welcomeLogo),
            SizedBox(
              height: 20.h,
            ),
            Text(
              AppLocalizations.of(context)!.welcomeText,
              style: AppTextStyles.welcomeText(isLight),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 50.h,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Register()),
                  );
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: ColorsManager.lightBlue,
                    padding: REdgeInsets.all(15)),
                child: Text(AppLocalizations.of(context)!.registerButton,
                    style: AppTextStyles.loginText)),
            SizedBox(
              height: 50.h,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Login(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: ColorsManager.lightBlue,
                    padding: REdgeInsets.all(15)),
                child: Text(
                  AppLocalizations.of(context)!.loginButton,
                  style: AppTextStyles.loginText,
                )),
          ],
        ));
  }
}
