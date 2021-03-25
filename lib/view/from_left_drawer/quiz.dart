import 'package:flutter/material.dart';
import '../../components/app_bar.dart';

//I haven't started to make this page. It is just showing for as a reminder(Like a Todo).

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Quiz'),
      body: Center(child: Text('Quiz Sayfası')),
    );
  }
}
