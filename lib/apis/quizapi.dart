// This file contains the QuizApiHelper class which is used to get questions from the quiz api.

// Developer Dependencies
import 'dart:developer';
// Imported Dependencies
import 'package:http/http.dart' as http;
// Project Dependencies
import 'package:quiz_flutter/sensitive_information/data.dart';

class QuizApiHelper {
  String method = "GET";
  String url = 'https://quizapi3.p.rapidapi.com/api/v1/questions';
  String key = API_KEY;

  void getQuestion(
    String category, {
    String difficulty = 'easy',
    required int limit,
  }) async {
    try {
      var questions = http.get(
        Uri.parse(url),
        headers: {
          'apiKey': 'YicDG9KrhU29rxHWHKkT0gJkmWwXIPkT2LxJVSVA',
          'limit': limit.toString(),
          'category': category,
        },
      );
      log(questions.toString());
    } catch (e) {
      log(e.toString());
    }
  }
}
