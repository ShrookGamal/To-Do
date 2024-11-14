import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:to_do/core/utils/constant_manager.dart';
import 'package:to_do/core/utils/dialog_utils/dialog_util.dart';
import 'package:to_do/core/utils/email_validation.dart';
import 'package:to_do/presentation/screens/welcome/login.dart';
import 'package:to_do/presentation/screens/welcome/widgets/custom_field.dart';

import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/colors_manager.dart';
import '../../../core/utils/text_styles.dart';
import '../../../database_manager/models/users_dm.dart';
import '../../../providers/settings_provider.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late TextEditingController userNameController;

  late TextEditingController emailController;

  late TextEditingController passwordController;

  late TextEditingController rePasswordController;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    rePasswordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    return Scaffold(
      backgroundColor:
          provider.isLight() ? Colors.white : ColorsManager.darkScaffold,
      body: SingleChildScrollView(
        child: Container(
          padding: REdgeInsets.only(top: 100, left: 30, right: 30),
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
                  height: 20.h,
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  AppLocalizations.of(context)!.userName,
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
                  height: 5.h,
                ),
                CustomField(
                  hint: AppLocalizations.of(context)!.userNameHint,
                  controller: userNameController,
                  keyBoardType: TextInputType.name,
                  icon: const Icon(Icons.person),
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return AppLocalizations.of(context)!.emptyUserName;
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15.h,
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
                  height: 5.h,
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
                    if (!isValidEmail(input)) {
                      return AppLocalizations.of(context)!.invalidEmail;
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15.h,
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
                  height: 5.h,
                ),
                CustomField(
                  hint: AppLocalizations.of(context)!.passwordHint,
                  controller: passwordController,
                  isSecured: true,
                  keyBoardType: TextInputType.visiblePassword,
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return AppLocalizations.of(context)!.emptyPassword;
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  AppLocalizations.of(context)!.confirmPassword,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: provider.isLight()
                          ? ColorsManager.lightBlack
                          : Colors.white),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 5.h,
                ),
                CustomField(
                  hint: AppLocalizations.of(context)!.confirmPasswordHint,
                  controller: rePasswordController,
                  keyBoardType: TextInputType.visiblePassword,
                  isSecured: true,
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return AppLocalizations.of(context)!.emptyPasswordConfirm;
                    }
                    if (input != passwordController.text) {
                      return AppLocalizations.of(context)!.notMatchedPassword;
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                ElevatedButton(
                    onPressed: () {
                      signUp();
                    },
                    child: Text(
                      AppLocalizations.of(context)!.registerButton,
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
                      AppLocalizations.of(context)!.haveAccount,
                      style: TextStyle(
                          color: provider.isLight()
                              ? ColorsManager.lightBlack
                              : Colors.white),
                    ),
                    InkWell(
                      child: Text(
                        AppLocalizations.of(context)!.signIn,
                        style: AppTextStyles.signup,
                      ),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
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

  Future<void> signUp() async {
    if (formKey.currentState?.validate() == false) return;
    try {
      DialogUtils.showLoading(context,
          message: AppLocalizations.of(context)!.wait);
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      addUsersToFireStore(credential.user!.uid);
      if (mounted) {
        DialogUtils.hide(context);
      }
      DialogUtils.showLoginMessage(
          context, AppLocalizations.of(context)!.successRegister);
    } on FirebaseAuthException catch (authError) {
      String? message;
      if (authError.code == ConstantManager.weekPasswordCode) {
        message = AppLocalizations.of(context)!.weekPassword;
      } else if (authError.code == ConstantManager.usedEmailCode) {
        message = AppLocalizations.of(context)!.existedEmail;
      }
      if (mounted) {
        DialogUtils.showMessage(context,
            title: AppLocalizations.of(context)!.error,
            content: message,
            posActionTitle: AppLocalizations.of(context)!.ok);
      }
    } catch (error) {
      if (mounted) {
        DialogUtils.hide(context);
        DialogUtils.showMessage(context, content: error.toString());
      }
    }
  }

  void addUsersToFireStore(String uid) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(UserDM.collectionName);
    DocumentReference documentReference = collectionReference.doc(uid);
    UserDM userDM = UserDM(
        id: uid,
        userName: userNameController.text,
        email: emailController.text);
    await documentReference.set(userDM.toFireStore());
  }
}
