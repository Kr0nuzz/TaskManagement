import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

enum SnackType { success, warning, error, info }

class AppSnackBar {
  static void show(BuildContext context,
      {required String title,
      required String message,
      required SnackType type,double elevation = 50}) {
    final contentType = switch (type) {
      SnackType.success => ContentType.success,
      SnackType.warning => ContentType.warning,
      SnackType.error => ContentType.failure,
      SnackType.info => ContentType.help,
    };
    final snackbar = SnackBar(
        elevation: elevation,
        backgroundColor: Colors.transparent,
        behavior: SnackBarBehavior.floating,
        content: AwesomeSnackbarContent(
            title: title, message: message, contentType: contentType));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackbar);
  }
}

