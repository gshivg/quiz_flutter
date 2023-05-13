import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_flutter/Models/theme.dart';
import 'package:quiz_flutter/pages/game/game_properties.dart';
import 'package:quiz_flutter/styles/appbar.dart';

import 'package:quiz_flutter/pages/game/quiz_container.dart';

class GameResult extends StatefulWidget {
  const GameResult({super.key, required this.gameProperties});
  final GameProperties gameProperties;
  @override
  State<GameResult> createState() => _GameResultState();
}

class _GameResultState extends State<GameResult> {
  int correctAnswers = 0;
  @override
  void initState() {
    super.initState();
    calculateScore();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ThemeModel themeModel, child) {
      storeScores();
      return Scaffold(
        appBar: standardAppBar2(themeModel, 'Standard Mode', context, true),
        body: Center(
          child: Text(
            'You answered $correctAnswers Correctly!',
            style: Theme.of(context).textTheme.displaySmall,
            textAlign: TextAlign.center,
          ),
        ),
      );
    });
  }

  void calculateScore() {
    for (var response in responses) {
      if (response) {
        correctAnswers += 1;
      }
    }
  }

  void storeScores() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('scores')
        .add({
      'score': correctAnswers,
      'date': DateTime.now(),
      'category': widget.gameProperties.category,
      'difficulty': widget.gameProperties.difficulty,
      'noOfQuestions': widget.gameProperties.noOfQuestions,
    });
    await FirebaseFirestore.instance.collection('high_scores').add({
      'score': correctAnswers,
      'date': DateTime.now(),
      'category': widget.gameProperties.category,
      'difficulty': widget.gameProperties.difficulty,
      'noOfQuestions': widget.gameProperties.noOfQuestions,
      'user': FirebaseAuth.instance.currentUser!.uid,
    });
  }
}
