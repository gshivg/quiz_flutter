// This file contains the MyHomePage class which is the home page of the app.

// ignore_for_file: must_be_immutable, prefer_const_constructors, use_build_context_synchronously, prefer_const_literals_to_create_immutables

// Developer Dependencies
import 'dart:developer';

// Flutter Dependencies
import 'package:flutter/material.dart';
// Imported Dependencies
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
// Project Dependencies
import 'package:quiz_flutter/Models/theme.dart';
import 'package:quiz_flutter/components/drawer.dart';
import 'package:quiz_flutter/pages/game/standard_mode_start_screen.dart';
import 'package:quiz_flutter/styles/appbar.dart';
import 'package:quiz_flutter/utils/ui_helper.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => UIHelper.showExitDialog(context),
      child: Consumer(
        builder: (context, ThemeModel themeNotifier, child) {
          return Scaffold(
            appBar: drawerAppBar(themeNotifier, 'Home Page', context),
            drawer: MyDrawer(),
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
                    disabled: true,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        homeScreenTileColumn(
                          'Play with Friends',
                          Icons.people_outline,
                          onPressed: comingSoon,
                          disabled: true,
                        ),
                        homeScreenTileColumn(
                          'Play with Randoms',
                          Icons.signpost_outlined,
                          onPressed: comingSoon,
                          disabled: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  homeScreenTileRow(
    String title,
    IconData icon, {
    double elevation = 5,
    VoidCallback? onPressed,
    bool disabled = false,
  }) =>
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
                    color: disabled
                        ? Theme.of(context).disabledColor
                        : Theme.of(context).colorScheme.primary,
                  ),
                  SizedBox(width: 15),
                  Text(
                    title,
                    style: disabled
                        ? Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Theme.of(context).disabledColor)
                        : Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  homeScreenTileColumn(
    String title,
    IconData icon, {
    double elevation = 5,
    VoidCallback? onPressed,
    bool disabled = false,
  }) =>
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
                    color: disabled
                        ? Theme.of(context).disabledColor
                        : Theme.of(context).colorScheme.primary,
                  ),
                  SizedBox(height: 15),
                  Text(
                    title,
                    style: disabled
                        ? Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Theme.of(context).disabledColor)
                        : Theme.of(context).textTheme.bodyLarge,
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
}
