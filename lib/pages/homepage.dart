// This file contains the MyHomePage class which is the home page of the app.

// ignore_for_file: must_be_immutable

// Flutter Dependencies
import 'package:flutter/material.dart';
// Imported Dependencies
import 'package:provider/provider.dart';
// Project Dependencies
import 'package:quiz_flutter/Models/theme.dart';
import 'package:quiz_flutter/pages/auth/auth_page.dart';
import 'package:quiz_flutter/pages/quizpage.dart';
import 'package:quiz_flutter/styles/appbar.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.signInKey});
  String signInKey;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ThemeModel themeNotifier, child) {
        return Scaffold(
          appBar: standardAppBar(themeNotifier, 'Home Page', context, false),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Home Page',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AuthPage(),
                ),
              );
            },
            tooltip: 'Increment',
            child: const Icon(
              Icons.logout,
            ),
          ),
        );
      },
    );
  }
}
