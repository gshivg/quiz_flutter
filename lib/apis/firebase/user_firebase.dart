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
    UIHelper.showLoadingDialog("Creating your account", context);
    try {
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (error) {
      Navigator.pop(context);
      if (error.code == 'email-already-in-use') {
        Fluttertoast.showToast(
          msg: 'This email is already linked with another account',
        );
        return;
      } else {
        Fluttertoast.showToast(
          msg: 'Some error has eccured',
        );
        return;
      }
    }

    String uid = userCredential.user!.uid;
    UserModel newUser = UserModel(
      uid: uid,
      email: email,
      age: '',
      name: '',
    );
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(newUser.toMap())
        .then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CreateProfilePage(
            firebaseUser: userCredential!.user!,
            userModel: newUser,
          ),
        ),
      );
    });
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
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MyHomePage(
          signInKey: userCredential!.user!.uid,
        ),
      ),
    );
  }
}
