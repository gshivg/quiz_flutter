// This file contains the code for the sign in page

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace

// Flutter Dependencies
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:password_strength/password_strength.dart';
// Imported Dependencies
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
// Project Dependencies
import 'package:quiz_flutter/Models/theme.dart';
import 'package:quiz_flutter/apis/firebase/main_firebase.dart';
import 'package:quiz_flutter/apis/firebase/user_firebase.dart';
import 'package:quiz_flutter/styles/appbar.dart';
import 'package:quiz_flutter/styles/buttons.dart';
import 'package:quiz_flutter/styles/text_field.dart';
import 'package:quiz_flutter/utils/ui_helper.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  FirebaseHelper firebaseHelper = FirebaseHelper();
  FlipCardController cardKey = FlipCardController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordCNFController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ThemeModel themeNotifier, child) {
        return Scaffold(
          appBar: standardAppBar(themeNotifier, 'My Tech Quiz', context, false),
          body: Center(
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.85,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox.shrink(),
                      FlipCard(
                        fill: Fill.fillBack,
                        controller: cardKey,
                        flipOnTouch: false,
                        side: CardSide.FRONT,
                        direction: FlipDirection.HORIZONTAL,
                        front: signCard(true),
                        back: signCard(false),
                      ),
                      ImageButton(() {
                        firebaseHelper.googleSignIn(context);
                      }, 'google', "Google", context),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  signCard(bool front) => Card(
        elevation: 5,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          height: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  front ? 'Sign In' : 'Sign Up',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              front ? signIn() : signUp(),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  front
                      ? PrimaryButton(signInFunction, 'Sign In', context)
                      : PrimaryButton(signUpFunction, 'Sign Up', context),
                  const SizedBox(height: 10),
                  otherOption(front),
                ],
              ),
            ],
          ),
        ),
      );

  signIn() => Column(
        children: [
          primaryTextField(
            _emailController,
            context,
            'Email',
            Icons.email_outlined,
          ),
          primaryTextField(
            _passwordController,
            context,
            'Password',
            Icons.lock_outlined,
            isPassword: true,
          ),
        ],
      );
  signUp() => Column(
        children: [
          primaryTextField(
            _emailController,
            context,
            'Email',
            Icons.email_outlined,
          ),
          primaryTextField(
            _passwordController,
            context,
            'Password',
            Icons.lock_outline,
            isPassword: true,
          ),
          primaryTextField(
            _passwordCNFController,
            context,
            'Confirm Password',
            Icons.lock_outline,
            isPassword: true,
          ),
        ],
      );

  void signInFunction() {
    UIHelper.showLoadingDialog('Signing In', context);
    String email = _emailController.text;
    String password = _passwordController.text;
    if (email.isEmpty || password.isEmpty) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: 'Please fill all the fields');
      return;
    }
    UserHelper.signInUser(email, password, context);
  }

  void signUpFunction() {
    UIHelper.showLoadingDialog('Logging In', context);
    String email = _emailController.text;
    String password = _passwordController.text;
    String passwordCNF = _passwordCNFController.text;
    if (email.isEmpty || password.isEmpty || passwordCNF.isEmpty) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: 'Please fill all the fields');
      return;
    } else if (password != passwordCNF) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: 'Passwords do not match');
      return;
    }
    double passwordStrength = estimatePasswordStrength(password);
    if (passwordStrength < 0.6) {
      Fluttertoast.showToast(
        msg: 'Password is too weak $passwordStrength',
      );
      Navigator.pop(context);
      return;
    }
    UserHelper.createNewUser(email, password, context);
  }

  otherOption(bool signIn) => Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(signIn ? "Don't have an account?" : "Already have an account?"),
          TextButton(
            onPressed: () {
              _emailController.clear();
              _passwordController.clear();
              _passwordCNFController.clear();
              FocusScope.of(context).unfocus();
              cardKey.toggleCard();
            },
            child: Text(
              signIn ? 'Sign Up' : 'Sign In',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      );
}
