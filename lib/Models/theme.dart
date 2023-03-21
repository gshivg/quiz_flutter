import 'package:flutter/material.dart';
import 'package:quiz_flutter/shared_preferences/theme.dart';

class ThemeModel extends ChangeNotifier {
  late bool _isDark;
  late ThemeSharedPreferences themeSharedPreferences;
  bool get isDark => _isDark;
  ThemeModel() {
    _isDark = false;
    themeSharedPreferences = ThemeSharedPreferences();
    getThemePreferences();
  }

  set isDark(bool value) {
    _isDark = value;
    themeSharedPreferences.setTheme(value);
    notifyListeners();
  }

  getThemePreferences() async {
    _isDark = await themeSharedPreferences.getTheme();
    notifyListeners();
  }

  void toggleTheme() {
    isDark = !isDark;
  }
}
