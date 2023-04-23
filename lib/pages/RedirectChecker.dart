// ignore_for_file: must_be_immutable, use_build_context_synchronously, file_names

import 'package:flutter/material.dart';
import 'package:quiz_flutter/apis/firebase/user_firebase.dart';
import 'package:quiz_flutter/shared_preferences/signin.dart';

class RedirectChecker extends StatefulWidget {
  const RedirectChecker({super.key});

  @override
  State<RedirectChecker> createState() => _RedirectCheckerState();
}

class _RedirectCheckerState extends State<RedirectChecker> {
  String? uid = '';
  @override
  Widget build(BuildContext context) {
    checkProfile();
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void checkProfile() async {
    SignInPreferences signInPreferences = SignInPreferences();
    uid = await signInPreferences.getSignIn();
    UserHelper.checkProfileCreated(uid!, context);
  }
}
