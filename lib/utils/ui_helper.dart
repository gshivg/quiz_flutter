import 'dart:ui';

import 'package:flutter/material.dart';

class UIHelper {
  static void showLoadingDialog(String title, BuildContext context) {
    AlertDialog loadingDialog = AlertDialog(
      content: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 25),
              Text(title),
            ],
          ),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      elevation: 10,
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: ((context) => loadingDialog),
      barrierColor: Colors.transparent,
    );
  }

  static void showConfirmationDialog(
      String title, BuildContext context, Function onYesPressed) {
    SimpleDialog confirmationDialog = SimpleDialog(
      title: Text(title),
      backgroundColor: Theme.of(context).colorScheme.background,
      elevation: 10,
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SimpleDialogOption(
              onPressed: () => onYesPressed(),
              child: const Text('Yes'),
            ),
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context),
              child: const Text('No'),
            ),
          ],
        ),
      ],
    );

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: ((context) => confirmationDialog),
      barrierColor: Colors.transparent,
    );
  }
}
