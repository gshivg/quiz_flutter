// This file contains the QuizApiHelper class which is used to get questions from the quiz api.

// Developer Dependencies
import 'dart:developer';
// Dart Dependencies
import 'dart:convert';
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
      var questions = await http.get(
        Uri.parse(url),
        headers: {
          'X-Api-Key': API_KEY,
          'limit': limit.toString(),
          'category': category,
        },
      );
      var responseData = jsonDecode(questions.body);
      log(responseData[1].toString());
    } catch (e) {
      log(e.toString());
    }
  }
}
