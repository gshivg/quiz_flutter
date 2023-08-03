import 'dart:ui';

import 'package:flutter/material.dart';

class UIHelper {
  static void showLoadingDialog(
    String title,
    BuildContext context,
  ) {
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
    String title,
    BuildContext context,
    Function onYesPressed,
  ) {
    SimpleDialog confirmationDialog = SimpleDialog(
      title: Text(title),
      backgroundColor:
          Theme.of(context).colorScheme.background.withOpacity(0.7),
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

  static Future<bool> showExitDialog(
    BuildContext context,
  ) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Exit App'),
            content: const Text('Do you want to exit the App?'),
            backgroundColor:
                Theme.of(context).colorScheme.background.withOpacity(0.7),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                //return false when click on "NO"
                child: const Text('No'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                //return true when click on "Yes"
                child: const Text('Yes'),
              ),
            ],
          ),
        ) ??
        false; //if showDialouge had returned null, then return false
  }
}
