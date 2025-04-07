class Question {
  final String questionText;
  final List<String> options;
  final int correctAnswer;

  // Constructor with named parameters
  Question({
    required this.questionText,
    required this.options,
    required this.correctAnswer,
  });
}
