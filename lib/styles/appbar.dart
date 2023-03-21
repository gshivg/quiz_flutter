// This file contains the AppBar class which is used to create the app bars for the app.

// Flutter Dependencies
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Project Dependencies
import 'package:quiz_flutter/Models/theme.dart';

AppBar standardAppBar(ThemeModel themeNotifier) => AppBar(
      title: const Text(
        'Home Page',
      ),
      actions: [
        IconButton(
          icon: Icon(
            themeNotifier.isDark ? CupertinoIcons.sun_max : CupertinoIcons.moon,
          ),
          onPressed: () {
            themeNotifier.toggleTheme();
          },
        ),
      ],
    );
