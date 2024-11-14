import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:to_do/core/utils/assets_manager.dart';
import 'package:to_do/presentation/screens/welcome/register.dart';
import 'package:to_do/presentation/screens/welcome/widgets/custom_field.dart';

import '../../../core/utils/colors_manager.dart';
import '../../../core/utils/constant_manager.dart';
import '../../../core/utils/dialog_utils/dialog_util.dart';
import '../../../core/utils/text_styles.dart';
import '../../../database_manager/models/users_dm.dart';
import '../../../providers/settings_provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController emailController;

  late TextEditingController passwordController;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    return Scaffold(
      backgroundColor:
          provider.isLight() ? Colors.white : ColorsManager.darkScaffold,
      body: SingleChildScrollView(
        child: Container(
          padding: REdgeInsets.only(top: 120, left: 30, right: 30),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(AssetsManager.loginIcon,
                    width: 100.h,
                    height: 120.h,
                    alignment: Alignment.topCenter),
                SizedBox(
                  height: 50.h,
                ),
                Text(
                  AppLocalizations.of(context)!.email,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: provider.isLight()
                        ? ColorsManager.lightBlack
                        : Colors.white,
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomField(
                  hint: AppLocalizations.of(context)!.emailHint,
                  controller: emailController,
                  keyBoardType: TextInputType.emailAddress,
                  icon: const Icon(Icons.email),
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return AppLocalizations.of(context)!.emptyEmail;
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  AppLocalizations.of(context)!.password,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: provider.isLight()
                          ? ColorsManager.lightBlack
                          : Colors.white),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomField(
                  hint: AppLocalizations.of(context)!.passwordHint,
                  controller: passwordController,
                  keyBoardType: TextInputType.visiblePassword,
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return AppLocalizations.of(context)!.emptyPassword;
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 30.h,
                ),
                ElevatedButton(
                    onPressed: () {
                      signIn();
                    },
                    child: Text(
                      AppLocalizations.of(context)!.loginButton,
                      style: TextStyle(
                          color: provider.isLight()
                              ? ColorsManager.lightBlack
                              : Colors.white),
                    )),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.doNotHaveAccount,
                      style: TextStyle(
                          color: provider.isLight()
                              ? ColorsManager.lightBlack
                              : Colors.white),
                    ),
                    InkWell(
                      child: Text(
                        AppLocalizations.of(context)!.signUp,
                        style: AppTextStyles.signup,
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Register()));
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signIn() async {
    if (formKey.currentState?.validate() == false) return;
    try {
      DialogUtils.showLoading(context,
          message: AppLocalizations.of(context)!.wait);
      UserCredential credential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      UserDM.currentUser = await readUserFromFireStore(credential.user!.uid);
      if (mounted) {
        DialogUtils.hide(context);
      }
      if (mounted) {
        DialogUtils.showLoginMessage(
          context,
          AppLocalizations.of(context)!.successLogin,
        );
      }
    } on FirebaseAuthException catch (authError) {
      String? message;
      if (authError.code == ConstantManager.invalidCredential) {
        message = AppLocalizations.of(context)!.wrongEmailOrPassword;
      }
      if (mounted) {
        DialogUtils.showMessage(
          context,
          title: AppLocalizations.of(context)!.error,
          content: message,
          posActionTitle: AppLocalizations.of(context)!.ok,
        );
      }
    } catch (error) {
      if (mounted) {
        DialogUtils.hide(context);
        DialogUtils.showMessage(context, content: error.toString());
      }
    }
  }

  Future<UserDM> readUserFromFireStore(String uid) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(UserDM.collectionName);
    DocumentReference documentReference = collectionReference.doc(uid);
    DocumentSnapshot documentSnapshot = await documentReference.get();
    Map<String, dynamic> json = documentSnapshot.data() as Map<String, dynamic>;
    UserDM userDM = UserDM.fromFireStore(json);
    return userDM;
  }
}
