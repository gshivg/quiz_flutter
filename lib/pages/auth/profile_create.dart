// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_flutter/Models/theme.dart';
import 'package:quiz_flutter/Models/user.dart';
import 'package:quiz_flutter/styles/appbar.dart';

class CreateProfilePage extends StatefulWidget {
  const CreateProfilePage(
      {super.key, required this.userModel, required this.firebaseUser});
  final UserModel userModel;
  final User firebaseUser;
  @override
  State<CreateProfilePage> createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ThemeModel themeNotifier, child) {
        return Scaffold(
          appBar: standardAppBar(themeNotifier, 'My Tech Quiz', context, false),
          body: Center(
            child: Text('Create Profile Page'),
          ),
        );
      },
    );
  }
}
