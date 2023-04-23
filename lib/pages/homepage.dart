// This file contains the MyHomePage class which is the home page of the app.

// ignore_for_file: must_be_immutable, prefer_const_constructors

// Flutter Dependencies
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// Imported Dependencies
import 'package:provider/provider.dart';
// Project Dependencies
import 'package:quiz_flutter/Models/theme.dart';
import 'package:quiz_flutter/apis/firebase/user_firebase.dart';
import 'package:quiz_flutter/pages/auth/auth_page.dart';
import 'package:quiz_flutter/pages/quizpage.dart';
import 'package:quiz_flutter/shared_preferences/signin.dart';
import 'package:quiz_flutter/styles/appbar.dart';
import 'package:quiz_flutter/utils/ui_helper.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String uid = '';
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ThemeModel themeNotifier, child) {
        return Scaffold(
          appBar: drawerAppBar(themeNotifier, 'Home Page', context),
          drawer: Drawer(
            elevation: 5,
            child: ListView(
              children: [
                DrawerHeader(
                  child: Text('Drawer Header'),
                ),
                ListTile(
                  title: Text('My Profile'),
                  onTap: () => Fluttertoast.showToast(msg: 'Profile'),
                ),
                ListTile(
                  title: Text('My High Scores'),
                  onTap: () => Fluttertoast.showToast(msg: 'High Scores'),
                ),
                ListTile(
                  title: Text('Show Friends'),
                  onTap: () => Fluttertoast.showToast(msg: 'Show Friends'),
                ),
                ListTile(
                  title: Text('Settings'),
                  onTap: () => Fluttertoast.showToast(msg: 'Settings'),
                ),
                ListTile(
                  title: Text('Sign Out'),
                  onTap: () => {
                    Navigator.pop(context),
                    UIHelper.showConfirmationDialog(
                        'Sign Out?', context, signOut)
                  },
                ),
              ],
            ),
          ),
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
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
              UIHelper.showConfirmationDialog(
                  'Confirm Exit?', context, signOut);
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

  void signOut() async {
    SignInPreferences signInPreferences = SignInPreferences();
    signInPreferences.deleteSignIn();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const AuthPage(),
      ),
    );
  }

  void checkProfile() async {
    SignInPreferences signInPreferences = SignInPreferences();
    uid = (await signInPreferences.getSignIn())!;
    UserHelper.checkProfileCreated(uid, context);
  }
}
