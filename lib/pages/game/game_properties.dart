import 'package:flutter/material.dart';

class GameProperties {
  String difficulty = 'easy';
  String category = '';
  late int noOfQuestions;
  late int timeLimit;

  GameProperties(
    this.difficulty,
    this.category, {
    this.noOfQuestions = 10,
    this.timeLimit = 15,
  });
}

List<Text> categories = [
  const Text('All Categories'),
  const Text('Linux'),
  const Text('DevOps'),
  const Text('SQL'),
  const Text('Code'),
  const Text('CMS'),
  const Text('Docker'),
];
