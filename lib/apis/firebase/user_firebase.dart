// ignore_for_file: unused_import, use_build_context_synchronously

// Developer Dependencies
import 'dart:developer';
// Flutter Dependencies
import 'package:flutter/material.dart';
// Imported Dependencies
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// Package Dependencies
import 'package:quiz_flutter/Models/user.dart';
import 'package:quiz_flutter/pages/auth/auth_page.dart';
import 'package:quiz_flutter/pages/auth/profile_create.dart';
import 'package:quiz_flutter/pages/homepage.dart';
import 'package:quiz_flutter/shared_preferences/signin.dart';
import 'package:quiz_flutter/utils/ui_helper.dart';

class UserHelper {
  static Future<UserModel?> getUserById(String uid) async {
    UserModel? userModel;
    DocumentSnapshot docSnap =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    userModel = UserModel.fromMap(docSnap.data() as Map<String, dynamic>);
    return userModel;
  }

  static Future<dynamic> createNewUser(
    String email,
    String password,
    BuildContext context,
  ) async {
    UserCredential? userCredential;
    Navigator.pop(context);
    UIHelper.showLoadingDialog("Creating your account", context);
    try {
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      Fluttertoast.showToast(
        msg: 'Login Successful',
      );
    } on FirebaseAuthException catch (error) {
      Navigator.pop(context);
      if (error.code == 'email-already-in-use') {
        Fluttertoast.showToast(
          msg: 'This email is already linked with another account',
        );
        return;
      }
       else {
        Fluttertoast.showToast(
          msg: 'Some error has eccured',
        );
        return;
      }
    }

    SignInPreferences signInPreferences = SignInPreferences();
    signInPreferences.setSignIn(userCredential.user!.uid);
    checkProfileCreated(userCredential.user!.uid, context);
  }

  static Future<dynamic> signInUser(
    String email,
    String password,
    BuildContext context,
  ) async {
    UserCredential? userCredential;
    UIHelper.showLoadingDialog("Signing you in", context);
    try {
      userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (error) {
      Navigator.pop(context);
      if (error.code == 'user-not-found') {
        Fluttertoast.showToast(
          msg: 'No user found for this email',
        );
        return;
      } else if (error.code == 'wrong-password') {
        Fluttertoast.showToast(
          msg: 'Wrong password provided for this user',
        );
        return;
      } else {
        Fluttertoast.showToast(
          msg: 'Some error has eccured',
        );
        return;
      }
    }

    SignInPreferences signInPreferences = SignInPreferences();
    signInPreferences.setSignIn(userCredential.user!.uid);

    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const MyHomePage(),
      ),
    );
  }

  static checkProfileCreated(String uid, BuildContext context) async {
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get()
          .then((value) {
        if (value.data() == null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => CreateProfilePage(
                uid: uid,
              ),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MyHomePage(),
            ),
          );
        }
      });
    } catch (e) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CreateProfilePage(
            uid: uid,
          ),
        ),
      );
    }
  }

  static void signOutUser(BuildContext context) async {
    SignInPreferences signInPreferences = SignInPreferences();
    signInPreferences.deleteSignIn();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const AuthPage(),
      ),
    );
  }

  static Future<String?> checkSignIn() async {
    SignInPreferences signInPreferences = SignInPreferences();
    return signInPreferences.getSignIn();
  }
}
