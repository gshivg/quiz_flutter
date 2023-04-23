// This file contains the theme data for light and dark modes.

// ignore_for_file: prefer_const_constructors

// Flutter Dependencies
import 'package:flutter/material.dart';

ThemeData darkTheme() => ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      fontFamily: 'Sono',
      dialogTheme: DialogTheme(
        backgroundColor: Colors.white54,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      drawerTheme: const DrawerThemeData(
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
      listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(),
        textColor: Colors.white,
        style: ListTileStyle.drawer,
      ),
    );

ThemeData lightTheme() => ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      fontFamily: 'Sono',
      dialogTheme: DialogTheme(
        backgroundColor: Colors.black45,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      drawerTheme: const DrawerThemeData(
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
      listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(),
        textColor: Colors.black,
        style: ListTileStyle.drawer,
      ),
    );
