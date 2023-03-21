// This file contains the QuizPage class which is the quiz page of the app.

// Flutter Dependencies
import 'package:flutter/material.dart';

// Imported Dependencies
import 'package:provider/provider.dart';

// Project Dependencies
import 'package:quiz_flutter/Models/theme.dart';
import 'package:quiz_flutter/apis/quizapi.dart';
import 'package:quiz_flutter/styles/appbar.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
    QuizApiHelper quizApiHelper = QuizApiHelper();
    quizApiHelper.getQuestion('linux', limit: 5);

    return Consumer(
      builder: (context, ThemeModel themeNotifier, child) {
        return Scaffold(
            appBar: standardAppBar(themeNotifier),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Theme Switcher',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ));
      },
    );
  }
}
