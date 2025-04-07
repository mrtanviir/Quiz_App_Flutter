import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz_app/question_model.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen>
    with SingleTickerProviderStateMixin {
  int currentQuestionIndex = 0;
  int score = 0;
  bool isAnswered = false;
  int? selectedAnswer;
  int timeLeft = 30;
  Timer? timer;
  late AnimationController _animationController;
  late Animation<double> _animation;

  final List<Color> optionsColors = [
    Color(0xFFF6B6B),
    Color(0xFF4ECDC4),
    Color(0xFFFFBE0B),
    Color(0xFF96E1D3)
  ];

  final List<Question> questions = [
    Question(
        questionText: "What is Flutter",
        options: [
          'A mobile dev framework',
          'A programming lang',
          'A database',
          'A design tool'
        ],
        correctAnswer: 0),
    Question(
        questionText: "Which company develop flutter",
        options: ['Apple', 'Google', 'Facebook', 'Microsoft'],
        correctAnswer: 1),
    Question(
        questionText: "What programming language is used in Flutter",
        options: ['Kotlin', 'Swift', 'Java', 'Dart'],
        correctAnswer: 3),
  ];

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: Duration(seconds: 30), vsync: this);
    _animation = Tween<double>(begin: 1, end: 0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    startTimer();
  }

  void startTimer() {
    timer?.cancel();
    timeLeft = 30;
    _animationController.reset();
    _animationController.forward();
    timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        if (timeLeft > 0) {
          setState(() {
            timeLeft--;
          });
        } else {
          timer.cancel();
          if (!isAnswered) {
            checkAnswer(-1);
          }
        }
      },
    );
  }

  void checkAnswer(int selectedIndex) {
    timer?.cancel();
    _animationController.stop();
    setState(() {
      isAnswered = true;
      selectedAnswer = selectedIndex;
      if (selectedIndex == questions[currentQuestionIndex].correctAnswer) {
        score++;
      }
    });
      Future.delayed(
        Duration(seconds: 2),
        () {
          nextQuestion();
        },
      );
  }

  void nextQuestion(){
    if(currentQuestionIndex < questions.length - 1){
      setState(() {
        currentQuestionIndex++;
        isAnswered=false;
        selectedAnswer = null;
      });
      startTimer();
    } else{
      showResults();
    }
  }

  void showResults(){
    showDialog(
        context: context,
        barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20)
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Color(0xFF6C63FF).withOpacity(0.1)
                ),
                child: Icon(
                    Icons.emoji_events,
                  size: 60,
                  color: Color(0xFF6C63FF),
                ),
              ),
              SizedBox(height: 20,),
              Text('Quiz Completed', style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2c3E50),
              ),
              ),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                decoration: BoxDecoration(
                  color: Color(0xFF6C63FF).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Score: $score/${questions.length}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6C63FF),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 30,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF6C63FF),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
                ),
                onPressed: () {
                Navigator.pop(context);
                setState(() {
                  currentQuestionIndex = 0;
                  score = 0;
                  isAnswered = false;
                  selectedAnswer = null;
                });
                startTimer();
              },
                child: Text("Play Again", style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),),
              )
            ],
          ),
        ),
      ),
    );
  }

  Color getButtonColor(int index){
    if(!isAnswered) return Colors.white;

    if(index == questions[currentQuestionIndex].correctAnswer){
      return Colors.green.shade400;
    }

    if(index == selectedAnswer && index != questions[currentQuestionIndex].correctAnswer){
      return Colors.redAccent;
    }

    return Colors.white;
  }

  void dispose(){
    timer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF6C63FF),
                  Color(0xFF3FD9D),
                ]
            )
        ),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20 ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.quiz, color: Colors.white, size: 20,),
                          SizedBox(width: 8,),
                          Text(
                            '${currentQuestionIndex + 1} / ${questions.length}'
                          )
                        ],
                      ),
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: CircularProgressIndicator(
                            value: _animation.value,
                            backgroundColor: Colors.white24,
                            valueColor: AlwaysStoppedAnimation(timeLeft > 10 ? Colors.white : Color(0xFFFF6B6B) ),
                          ),
                        ),
                        Text(timeLeft.toString(),style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),)
                      ],
                    )
                  ],
                ),
              ),
              Expanded(child: SingleChildScrollView(
                padding: EdgeInsets.all(20),
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 20,
                            offset: Offset(0,10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.lightbulb_outline,
                          color: Color(0xFF6C63FF),
                            size: 40,
                          ),
                          SizedBox(height: 20,),
                          Text(
                            questions[currentQuestionIndex].questionText,
                          // style: TextStyle(
                          //   fontSize: 22,
                          //   fontWeight: FontWeight.bold,
                          //   height: 1.5,
                          //   color: Color(0xFF2C3E5),
                          //
                          // ),
                          textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 30,),
                    Column(
                      children: List.generate(questions[currentQuestionIndex].options.length, (index) => Padding(
                          padding:EdgeInsets.only(bottom: 15),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          child: InkWell(
                            onTap: isAnswered ? null : () => checkAnswer(index),
                            child: Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: isAnswered ? getButtonColor(index) : Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: optionsColors[index].withOpacity(0.3),
                                    blurRadius: 10,
                                    offset: Offset(0, 5)
                                  )
                                ]
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: optionsColors[index].withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Center(
                                      child: Text(String.fromCharCode(65 + index),
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: optionsColors[index],
                                      ),
                                      ),

                                    ),
                                  ),
                                  SizedBox(width: 15,),
                                  Expanded(
                                    child: Text(
                                    questions[currentQuestionIndex].options[index],
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: isAnswered && getButtonColor(index) != Colors.white ? Colors.white : Color(0xFF2c3E50))
                                    ),
                                  ),

                                  if(isAnswered)...[
                                    SizedBox(width: 10,),
                                    Icon(
                                      color: Colors.white,
                                      getButtonColor(index) == Colors.green.shade400 ? Icons.check_circle : (getButtonColor(index) == Colors.redAccent ? Icons.cancel : null),
                                    )
                                  ]
                                ],
                              ),
                            ),
                          ),
                        ),
                        ),
                      ),
                    )
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
