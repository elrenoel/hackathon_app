class Question {
  final String question;
  final List<String>? options;
  final int? correctIndex;
  final bool isInput;

  Question({
    required this.question,
    this.options,
    this.correctIndex,
    this.isInput = false,
  });
}

class UserAnswer {
  final int questionIndex;
  final int? selectedOption;
  final String? textAnswer;

  UserAnswer({
    required this.questionIndex,
    this.selectedOption,
    this.textAnswer,
  });
}
