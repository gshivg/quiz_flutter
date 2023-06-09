// This file contains the AppBar class which is used to create the app bars for the app.

// ignore_for_file: prefer_const_constructors

// Flutter Dependencies
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Project Dependencies
import 'package:quiz_flutter/Models/theme.dart';

AppBar standardAppBar(ThemeModel themeNotifier, String title,
        BuildContext context, bool leading) =>
    AppBar(
      title: Text(title),
      actions: [
        IconButton(
          icon: Icon(
            themeNotifier.isDark ? CupertinoIcons.sun_max : CupertinoIcons.moon,
          ),
          onPressed: () {
            FocusScope.of(context).unfocus();
            themeNotifier.toggleTheme();
          },
        ),
      ],
      automaticallyImplyLeading: leading,
    );

AppBar drawerAppBar(
        ThemeModel themeNotifier, String title, BuildContext context) =>
    AppBar(
      leading: Builder(builder: (context) {
        return IconButton(
          icon: Icon(Icons.menu),
          onPressed: () => Scaffold.of(context).openDrawer(),
        );
      }),
      title: Text(title),
      actions: [
        IconButton(
          icon: Icon(
            themeNotifier.isDark ? CupertinoIcons.sun_max : CupertinoIcons.moon,
          ),
          onPressed: () {
            FocusScope.of(context).unfocus();
            themeNotifier.toggleTheme();
          },
        ),
      ],
      automaticallyImplyLeading: false,
    );

AppBar standardAppBar2(ThemeModel themeNotifier, String title,
        BuildContext context, bool leading) =>
    AppBar(
      title: Text(title),
      automaticallyImplyLeading: leading,
    );