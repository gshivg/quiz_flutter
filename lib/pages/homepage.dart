// This file contains the MyHomePage class which is the home page of the app.

// ignore_for_file: must_be_immutable, prefer_const_constructors, use_build_context_synchronously, prefer_const_literals_to_create_immutables

// Flutter Dependencies
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// Imported Dependencies
import 'package:provider/provider.dart';
// Project Dependencies
import 'package:quiz_flutter/Models/theme.dart';
import 'package:quiz_flutter/pages/auth/auth_page.dart';
import 'package:quiz_flutter/pages/drawer-pages/leaderboard.dart';
import 'package:quiz_flutter/pages/game/standard_mode_start_screen.dart';
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
                  leading: Icon(Icons.person_outlined),
                  onTap: () => Fluttertoast.showToast(msg: 'Profile'),
                ),
                ListTile(
                  title: Text('Show Friends'),
                  leading: Icon(Icons.people_outlined),
                  onTap: () => Fluttertoast.showToast(msg: 'Show Friends'),
                ),
                ListTile(
                  title: Text('Leaderboard'),
                  leading: Icon(Icons.leaderboard_outlined),
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LeaderBoard())),
                ),
                ListTile(
                  title: Text('Settings'),
                  leading: Icon(Icons.settings_outlined),
                  onTap: () => Fluttertoast.showToast(msg: 'Settings'),
                ),
                ListTile(
                  title: Text('Sign Out'),
                  leading: Icon(Icons.logout_outlined),
                  onTap: () => {
                    Navigator.pop(context),
                    UIHelper.showConfirmationDialog(
                        'Sign Out?', context, signOut)
                  },
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                homeScreenTileRow(
                  'Standard Mode',
                  Icons.star_border_outlined,
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StandardModeStartScreen(),
                    ),
                  ),
                ),
                homeScreenTileRow(
                  'Rapid Fire',
                  Icons.timer_outlined,
                  onPressed: comingSoon,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      homeScreenTileColumn(
                        'Play with Friends',
                        Icons.people_outline,
                        onPressed: comingSoon,
                      ),
                      homeScreenTileColumn(
                        'Play with Randoms',
                        Icons.signpost_outlined,
                        onPressed: comingSoon,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  homeScreenTileRow(String title, IconData icon,
          {double elevation = 5, VoidCallback? onPressed}) =>
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: ElevatedButton(
            onPressed: onPressed,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 40,
                  ),
                  SizedBox(width: 15),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  homeScreenTileColumn(String title, IconData icon,
          {double elevation = 5, VoidCallback? onPressed}) =>
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: ElevatedButton(
            onPressed: onPressed,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 35,
                  ),
                  SizedBox(height: 15),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  void comingSoon() {
    log('Feature Coming Soon');
    Fluttertoast.showToast(msg: 'Feature Coming Soon');
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
}
