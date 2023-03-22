// This file contains the code for the sign in page

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

// Flutter Dependencies
import 'package:flutter/material.dart';
// Imported Dependencies
import 'package:provider/provider.dart';
// Project Dependencies
import 'package:quiz_flutter/Models/theme.dart';
import 'package:quiz_flutter/apis/firebase.dart';
import 'package:quiz_flutter/styles/appbar.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    FirebaseHelper firebaseHelper = FirebaseHelper();

    return Consumer(
      builder: (context, ThemeModel themeNotifier, child) {
        return Scaffold(
          appBar: standardAppBar(themeNotifier, 'My Tech Quiz'),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Sign In',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                ElevatedButton(
                  onPressed: () => {firebaseHelper.googleSignIn(context)},
                  child: buttonDesign('google', "Google Sign In"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  buttonDesign(String image, String title) => Container(
        width: 200,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 30.0,
              width: 30.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/$image.png'),
                  fit: BoxFit.cover,
                ),
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      );

  signup(BuildContext context) {}
}
