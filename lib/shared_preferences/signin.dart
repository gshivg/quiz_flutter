// ignore_for_file: constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

class SignInPreferences {
  static const PREF_KEY = "signInPreference";

  void setSignIn(String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(PREF_KEY, value);
  }

  getSignIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(PREF_KEY);
  }

  deleteSignIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(PREF_KEY);
  }
}
