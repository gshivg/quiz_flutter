// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_flutter/Models/theme.dart';
import 'package:quiz_flutter/apis/quizapi/main.dart';
import 'package:quiz_flutter/pages/game/game_properties.dart';
import 'package:quiz_flutter/styles/appbar.dart';

class GameScreen extends StatefulWidget {
  GameScreen({super.key, required this.gameProperties});
  GameProperties gameProperties;
  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  QuizApiHelper quizApiHelper = QuizApiHelper();
  dynamic questions;

  @override
  void initState() {
    super.initState();
    quizApiHelper
        .getQuestions(
      difficulty: widget.gameProperties.difficulty,
      limit: widget.gameProperties.noOfQuestions,
      category: widget.gameProperties.category == "All Categories"
          ? ''
          : widget.gameProperties.category,
    )
        .then(
      (value) {
        setState(() {
          questions = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ThemeModel themeModel, child) {
      return Scaffold(
        appBar:
            standardAppBar2(themeModel, 'Start Standard Mode', context, true),
        body: const Center(child: Text("Game Screen")),
      );
    });
  }
}
