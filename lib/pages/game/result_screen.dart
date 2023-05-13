import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_flutter/Models/theme.dart';
import 'package:quiz_flutter/styles/appbar.dart';

import 'package:quiz_flutter/pages/game/quiz_container.dart';

class GameResult extends StatefulWidget {
  const GameResult({super.key});

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
}
