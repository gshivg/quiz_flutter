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
  String authority = "quizapi3.p.rapidapi.com";
  String path = "/api/v1/questions";
  String key = QUIZAPI_KEY;

  Future<dynamic> getQuestions({
    String category = '',
    String difficulty = 'easy',
    required int limit,
  }) async {
    final uri = Uri.https(authority, path, {
      'category': category.toLowerCase(),
      'difficulty': difficulty,
      'limit': limit.toString(),
    });
    try {
      var questions = await http.get(
        uri,
        headers: {
          'X-Api-Key': QUIZAPI_KEY,
        },
      );
      if (questions.statusCode != 200) {
        log(questions.body);
        return;
      }
      var responseData = jsonDecode(questions.body);
      for (var data in responseData) {
        data.removeWhere((key, value) => key == 'id');
        data.removeWhere((key, value) => key == 'explanation');
        data.removeWhere((key, value) => key == 'description');
        data.removeWhere((key, value) => key == 'tip');
        data.removeWhere((key, value) => key == 'tags');
        data.removeWhere((key, value) => key == 'difficulty');
      }
      for (var data in responseData) {
        if (data['multiple_correct_answers'] == true ||
            data['multiple_correct_answers'] == 'true') {
          return getQuestions(
            limit: limit,
            category: category,
            difficulty: difficulty,
          );
        }
      }
      return responseData;
    } catch (e) {
      log(e.toString());
    }
  }
}
