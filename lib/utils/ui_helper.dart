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
      backgroundColor: Colors.white54,
      elevation: 40,
    );

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: ((context) => loadingDialog),
      barrierColor: Colors.transparent,
    );
  }
}
