// ignore_for_file: unused_local_variable, use_build_context_synchronously

// Developer Dependencies
import 'dart:developer';
// Flutter Dependencies
import 'package:flutter/material.dart';
// Imported Dependencies
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quiz_flutter/pages/homepage.dart';
// Package Dependencies
import 'package:quiz_flutter/shared_preferences/signin.dart';

class FirebaseHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  SignInPreferences signInPreferences = SignInPreferences();

  Future googleSignIn(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount == null) return;

    try {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );
      UserCredential result = await _auth.signInWithCredential(authCredential);
      User? user = result.user;
      log(user!.uid.toString());
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(
            signInKey: user.uid.toString(),
          ),
        ),
      );
      signInPreferences.setSignIn(user.uid.toString());
    } catch (e) {
      return e;
    }
  }

  Future signOut() async {
    try {
      await _auth.signOut();
      signInPreferences.deleteSignIn();
    } catch (e) {
      return e;
    }
  }
}
