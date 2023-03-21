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
import 'package:quiz_flutter/firebase_options.dart';
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
                Card(
                  margin: const EdgeInsets.only(
                      top: 100, bottom: 200, left: 30, right: 30),
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        signInButton(context, 'google', 'Sign In With Google', firebaseHelper.googleSignIn(context)),
                        signInButton(
                            context, 'facebook', 'Sign In With Facebook', firebaseHelper.facebookSignIn(context)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  signInButton(BuildContext context, String image, String title, Future<void> onPress) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: MaterialButton(
          onPressed: () => onPress,
          elevation: 10,
          child: buttonDesign(image, title),
        ),
      );

  Row buttonDesign(String image, String title) => Row(
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
      );

  signup(BuildContext context) {}
}
