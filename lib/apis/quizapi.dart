import 'dart:developer';

import 'package:http/http.dart' as http;

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
      var questions = http.get(Uri.parse(url), headers: {
        'apiKey' : 'YicDG9KrhU29rxHWHKkT0gJkmWwXIPkT2LxJVSVA'
        
      });
    } catch (e) {
      log(e.toString());
    }
  }
}
