// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quiz_flutter/pages/game/game_properties.dart';

import 'package:quiz_flutter/pages/game/game_screen.dart';
import 'package:quiz_flutter/pages/game/result_screen.dart';

var responses = [];

class QuizContainer extends StatefulWidget {
  const QuizContainer({
    super.key,
    required this.questionNo,
    required this.questionData,
    required this.callback,
    required this.gameProperties,
  });
  final int questionNo;
  final Map<String, dynamic> questionData;
  final Function callback;
  final GameProperties gameProperties;
  @override
  State<QuizContainer> createState() => _QuizContainerState();
}

class _QuizContainerState extends State<QuizContainer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> answers = widget.questionData['answers'];
    String image = widget.questionData['category'].toString().toLowerCase();
    image = (image == '' || image == ' ' || image == null) ? 'atom' : image;
    bool multipleCorrectAnswers =
        (widget.questionData['multiple_correct_answers'].toString() == 'true'
            ? true
            : false);
    Map<String, dynamic> correctAnswersMap =
        widget.questionData['correct_answers'];

    var validanswers = [];
    for (var answer in answers.entries) {
      if (answer.value == 'null' || answer.value == null) {
        continue;
      }
      validanswers.add(answer.value.toString());
    }
    var correctAnswersArray = [];
    for (var element in correctAnswersMap.values) {
      if (element == 'true' || element == true) {
        correctAnswersArray.add(true);
      } else {
        correctAnswersArray.add(false);
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: SvgPicture.asset(
              'assets/images/svg/$image.svg',
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.onBackground,
                BlendMode.srcATop,
              ),
              width: MediaQuery.of(context).size.width * 0.5,
            ),
          ),
          SizedBox(height: 20),
          Text(
            '${widget.questionNo}) ${widget.questionData['question']}',
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 20),
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: validanswers.length,
              itemBuilder: (context, index) {
                return QuizOptionSingle(
                  index: index + 1,
                  option: validanswers.elementAt(index),
                  isCorrect: correctAnswersArray.elementAt(index) as bool,
                  multicorrect: multipleCorrectAnswers,
                  callback: widget.callback,
                  gameProperties: widget.gameProperties,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class QuizOptionSingle extends StatefulWidget {
  const QuizOptionSingle({
    super.key,
    required this.index,
    required this.option,
    required this.isCorrect,
    required this.callback,
    required this.multicorrect,
    required this.gameProperties,
  });
  final int index;
  final String option;
  final bool isCorrect;
  final Function callback;
  final bool multicorrect;
  final GameProperties gameProperties;
  @override
  State<QuizOptionSingle> createState() => _QuizOptionSingleState();
}

class _QuizOptionSingleState extends State<QuizOptionSingle> {
  late bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            pressed = true;
          });
          if (widget.isCorrect) {
            responses.add(true);
          } else {
            responses.add(false);
          }
          Future.delayed(
            const Duration(milliseconds: 600),
            () {
              if (index != totalQuestions - 1) {
                setState(() {
                  index += 1;
                  widget.callback();
                });
                return;
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return GameResult(
                        gameProperties: widget.gameProperties,
                      );
                    },
                  ),
                );
              }
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: ListTile(
            trailing: Visibility(
              visible: widget.multicorrect,
              child: Icon(Icons.numbers),
            ),
            title: Text(
              '${widget.index}) ${widget.option}',
              style: pressed
                  ? Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: widget.isCorrect ? Colors.green : Colors.red,
                      )
                  : Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.start,
            ),
          ),
        ),
      ),
    );
  }
}
