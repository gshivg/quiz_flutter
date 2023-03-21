// ignore_for_file: unused_local_variable, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quiz_flutter/pages/homepage.dart';

class FirebaseHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> googleSignIn(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount == null) return;

    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential authCredential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken,
    );
    UserCredential result = await _auth.signInWithCredential(authCredential);
    User? user = result.user;

    if (result != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(
            signInKey: user!.uid.toString(),
          ),
        ),
      );
    }
  }

  Future<void> facebookSignIn(BuildContext context) async {}
}
