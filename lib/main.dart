//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:quizzer/quizbrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       home: Scaffold(
         backgroundColor: Colors.grey.shade900,
         body: SafeArea(
           child: Padding(
             padding: const EdgeInsets.symmetric(horizontal: 10.0),
             child: QuizPage(),
           ),
         ),
       ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

    List<Icon> scoreKeeper = [];

    void checkAnswer(bool userPicked){
      if(scoreKeeper.length < 13) {
      setState(() {
      bool correctAnswer = quizBrain.getQuestionAnswer();
        if (userPicked == correctAnswer) {
          scoreKeeper.add(Icon(Icons.check, color: Colors.green,));
        }
        else {
          scoreKeeper.add(Icon(Icons.close, color: Colors.red,));
        }
        quizBrain.nextQuestion();
      });
      }
      else{
          Alert(context: context, title: "Congratulations!!", desc: "Quiz is completed").show();
          setState(() {
            quizBrain.questionNNumber = 0;
            scoreKeeper.clear();
          });
      }
    }

    QuizBrain quizBrain = new QuizBrain();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
         children: scoreKeeper
        ),
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
