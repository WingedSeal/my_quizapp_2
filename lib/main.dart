import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(const Quizzler());

class Quizzler extends StatelessWidget {
  const Quizzler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "Quiz App",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            backgroundColor: Colors.grey[850]),
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];
  List<Icon> lastScoreKeeper = [];
  int score = 0;
  int lastScore = 0;

  void checkAnswer(bool userAns) {
    bool isCorrect = quizBrain.getQuestionAnswer() == userAns;
    setState(() {
      if (isCorrect) {
        score++;
        scoreKeeper.add(Icon(
          Icons.check,
          color: Colors.green[800],
        ));
      } else {
        scoreKeeper.add(const Icon(
          Icons.close,
          color: Colors.red,
        ));
      }
      // Next Question
      quizBrain.nextQuestion();
      if (quizBrain.isFinished()) {
        Alert(context: context, title: "QuizApp", desc: "Out of question.")
            .show();
        quizBrain.reset();
        lastScoreKeeper = scoreKeeper;
        lastScore = score;
        scoreKeeper = [];
        score = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                '$score',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 35.0,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.green),
              child: const Text(
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
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.red),
              child: const Text(
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
        Column(
          children: [
            Row(
              children: [
                const Text("Current Score: "),
                Row(
                  children: scoreKeeper,
                ),
              ],
            ),
            Row(
              children: [
                const Text("Last Score: "),
                Row(
                  children: lastScoreKeeper,
                ),
                const Expanded(
                  child: SizedBox(),
                ),
                Text("Total: $lastScore"),
              ],
            ),
          ],
        )
      ],
    );
  }
}
