// ignore_for_file: prefer_const_constructors, must_be_immutable, sized_box_for_whitespace

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:quiz_flutter/Models/theme.dart';
import 'package:quiz_flutter/Models/user.dart';
import 'package:quiz_flutter/pages/homepage.dart';
import 'package:quiz_flutter/styles/appbar.dart';
import 'package:quiz_flutter/styles/buttons.dart';
import 'package:quiz_flutter/styles/text_field.dart';

class CreateProfilePage extends StatefulWidget {
  CreateProfilePage({super.key, required this.uid});
  String uid;
  @override
  State<CreateProfilePage> createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ThemeModel themeNotifier, child) {
        return Scaffold(
          appBar: standardAppBar(themeNotifier, 'My Tech Quiz', context, false),
          body: Center(
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 500,
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          'Create Profile',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ),
                      Column(
                        children: [
                          primaryTextField(nameController, context,
                              'Enter Name', Icons.person),
                          primaryTextField(
                            ageController,
                            context,
                            'Enter Your Age',
                            Icons.calendar_today,
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          PrimaryButton(
                              () => createProfile(), 'Continue', context),
                          SizedBox(height: 20),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void createProfile() async {
    if (nameController.text.isEmpty || ageController.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Please fill all the fields');
      return;
    }
    UserModel user = UserModel(
      uid: widget.uid,
      name: nameController.text,
      age: ageController.text,
      email: FirebaseAuth.instance.currentUser!.email!,
    );
    log(user.toMap().toString());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.uid)
        .set(user.toMap())
        .then(
          (value) => {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const MyHomePage(),
              ),
            ),
          },
        );
  }
}
