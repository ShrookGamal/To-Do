import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../routes_manager.dart';

class DialogUtils {
  static void showLoading(context,
      {required String message, bool isDismissable = true}) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Row(
                children: [
                  Text(message),
                  const Spacer(),
                  const CircularProgressIndicator()
                ],
              ),
            ),
        barrierDismissible: isDismissable);
  }

  static void hide(context) {
    Navigator.pop(context);
  }

  static void showMessage(
    context, {
    String? title,
    String? content,
    String? posActionTitle,
    String? negativeActionTitle,
    VoidCallback? posAction,
    VoidCallback? negAction,
  }) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: title != null ? Text(title) : null,
            content: content != null ? Text(content) : null,
            actions: [
              if (posActionTitle != null)
                MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                      posAction?.call();
                    },
                    child: Text(posActionTitle)),
              if (negativeActionTitle != null)
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      negAction?.call();
                    },
                    child: Text(negativeActionTitle))
            ],
          );
        });
  }

  static void showLoginMessage(context, text) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 50,
        ),
        content: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
      ),
    );
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, RoutesManager.homeRoute);
    });
  }
}
