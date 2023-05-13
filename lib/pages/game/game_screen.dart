// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_flutter/Models/theme.dart';
import 'package:quiz_flutter/apis/quizapi/main.dart';
import 'package:quiz_flutter/pages/game/game_properties.dart';
import 'package:quiz_flutter/pages/game/quiz_container.dart';
import 'package:quiz_flutter/styles/appbar.dart';
import 'package:quiz_flutter/styles/buttons.dart';
import 'package:async/async.dart';
import 'package:quiz_flutter/pages/game/quiz_container.dart';

int index = 0;
late int totalQuestions;

class GameScreen extends StatefulWidget {
  const GameScreen({super.key, required this.gameProperties});
  final GameProperties gameProperties;
  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  QuizApiHelper quizApiHelper = QuizApiHelper();
  final AsyncMemoizer _memoizer = AsyncMemoizer();
  int correctAnswers = 0;
  @override
  void initState() {
    super.initState();
    index = 0;
    responses = [];
  }

  void callback() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    totalQuestions = widget.gameProperties.noOfQuestions;
    return Consumer(builder: (context, ThemeModel themeModel, child) {
      return Scaffold(
        appBar: standardAppBar2(themeModel, 'Standard Mode', context, true),
        body: FutureBuilder(
          future: _memoizer.runOnce(
            () => quizApiHelper.getQuestions(
              difficulty: widget.gameProperties.difficulty,
              limit: widget.gameProperties.noOfQuestions,
              category: widget.gameProperties.category == "All Categories"
                  ? ''
                  : widget.gameProperties.category,
            ),
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Image.asset(
                  'assets/images/gifs/loading.gif',
                ),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text('Error'),
              );
            }
            if (snapshot.data == null) {
              return const Center(
                child: Text('No Data, Try Again Later!'),
              );
            }
            return SingleChildScrollView(
              child: IndexedStack(
                index: index,
                children: List.generate(
                  widget.gameProperties.noOfQuestions,
                  (index) => QuizContainer(
                    questionNo: index + 1,
                    questionData: snapshot.data[index],
                    callback: callback,
                    gameProperties: widget.gameProperties,
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
