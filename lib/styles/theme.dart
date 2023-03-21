// This file contains the theme data for light and dark modes.

// Flutter Dependencies
import 'package:flutter/material.dart';

ThemeData darkTheme() => ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      fontFamily: 'Sono',
    );

ThemeData lightTheme() => ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      fontFamily: 'Sono',
    );
