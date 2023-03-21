// This file contains the code for the sign in page

// Flutter Dependencies
import 'package:flutter/material.dart';
// Imported Dependencies
import 'package:provider/provider.dart';
// Project Dependencies
import 'package:quiz_flutter/Models/theme.dart';
import 'package:quiz_flutter/styles/appbar.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ThemeModel themeNotifier, child) {
        return Scaffold(
          appBar: standardAppBar(themeNotifier, 'Quiz Page'),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Sign In Page',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                
              ],
            ),
          ),
        );
      },
    );
  }
}
