import 'package:flutter/material.dart';
import 'package:one_day_one_word/core/base/base_state.dart';
import 'package:one_day_one_word/core/components/app_bar.dart';

//I haven't started to make this page. It is just showing for as a reminder(Like a Todo).

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> with BaseState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: applicationStrings.titleQuiz),
      body: Center(child: Text('Quiz Sayfası')),
    );
  }
}
