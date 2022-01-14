import 'question.dart';

class QuizBrain {
  int _questionNumber = 0;

  final List<Question> _questionBank = const [
    Question(
        'Bob bought 10 apples, for 5\$ each. Is temperature at the surface of the sun more than 6,600 Celsius?',
        false),
    Question(
        'From the fact that there is a quantum property of electrons called spin, does electron actually spin?',
        false),
    Question(
        'In python programming lanuage, you can put as many "yield" keyword as you want in a function.',
        true),
    Question('Github was created in 2007.', false),
    Question(
        'In python programming lanuage, default of "str(object)" will call "__str__" and then "__repr__" if that "__str__" method is not found.',
        true),
    Question('HTML with CSS is turing complete.', true),
    Question('Does every program that works on C work on C++?', false),
    Question('"React" is a frontend framework.', false),
    Question('Squirrel can survive impacts at their terminal velocity.', true),
  ];

  bool nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
      return true;
    }
    return false;
  }

  String getQuestionText() => _questionBank[_questionNumber].questionText;

  bool getQuestionAnswer() => _questionBank[_questionNumber].questionAnswer;

  bool isFinished() => _questionNumber >= _questionBank.length - 1;

  void reset() {
    _questionNumber = 0;
  }
}
