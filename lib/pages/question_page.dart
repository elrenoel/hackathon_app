import 'package:flutter/material.dart';
// import 'package:hackathon_app/pages/deep_read_page.dart';
// import 'package:hackathon_app/pages/success_page.dart';
// import 'package:hackathon_app/services/reading_progress_service.dart';
import 'package:hackathon_app/pages/review_answer_page.dart';
import 'package:hackathon_app/models/question_models.dart';
// import 'package:hackathon_app/models/article_meta.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  final List<UserAnswer> userAnswers = [];
  int _currentIndex = 0;
  String? _selectedOption;
  final TextEditingController _answerController = TextEditingController();

  final List<Question> _questions = [
    Question(
      question:
          'What was the main reason the author originally opposed learning two languages at the same time?',
      options: [
        'They believed the brain cannot handle more than one language',
        'They were a perfectionist who believed full focus on one language was necessary',
        'They had never been exposed to multiple languages',
        'They thought learning languages was only for children',
        'They did not enjoy learning languages',
      ],
      correctIndex: 1,
    ),
    Question(
      question:
          'What helped change the author’s perspective on learning multiple languages?',
      options: [
        'Learning Spanish as a child',
        'Growing up with two languages',
        'Studying linguistics in college',
        'Moving to another country',
      ],
      correctIndex: 1,
    ),
    Question(
      question:
          'According to the text, how did learning multiple languages impact the author’s personal and professional life?',
      isInput: true,
    ),
  ];

  void _nextQuestion() {
    userAnswers.add(
      UserAnswer(
        questionIndex: _currentIndex,
        selectedOption: _selectedOption != null
            ? _questions[_currentIndex].options!.indexOf(_selectedOption!)
            : null,
        textAnswer: _answerController.text.isNotEmpty
            ? _answerController.text
            : null,
      ),
    );
    if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex++;
        _selectedOption = null;
        _answerController.clear();
      });
    } else {
      // ReadingProgressService.addReadingSession(
      //   // minutes: widget.articleMeta.duration,
      //   minutes: 10,
      // );
      // ReadingProgressService.addQuestionsAnswered(
      //   _questions.length, // jumlah soal (3)
      // );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
              ReviewAnswerPage(questions: _questions, userAnswers: userAnswers),
        ),
      ); // selesai → balik ke DeepRead
    }
  }

  @override
  void initState() {
    super.initState();

    _answerController.addListener(() {
      setState(() {}); // rebuild saat user ngetik
    });
  }

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final question = _questions[_currentIndex];

    return Scaffold(
      backgroundColor: const Color(0xFFF6F2FA),
      appBar: AppBar(
        title: Text('Question ${_currentIndex + 1}'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question.question,
              style: Theme.of(
                context,
              ).textTheme.labelLarge?.copyWith(height: 1.4),
            ),
            const SizedBox(height: 20),

            // ================= MCQ =================
            if (!question.isInput)
              ...question.options!.map(
                (option) => _OptionButton(
                  text: option,
                  isSelected: _selectedOption == option,
                  onTap: () {
                    setState(() {
                      _selectedOption = option;
                    });
                  },
                ),
              ),

            // ================= INPUT =================
            if (question.isInput)
              Container(
                height: 180,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF7C4DFF)),
                ),
                child: TextField(
                  controller: _answerController,
                  maxLines: null,
                  expands: true,
                  decoration: const InputDecoration(
                    hintText: 'Type your answer',
                    border: InputBorder.none,
                  ),
                ),
              ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: question.isInput
                    ? _answerController.text.trim().isNotEmpty
                          ? _nextQuestion
                          : null
                    : _selectedOption != null
                    ? _nextQuestion
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7C4DFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  _currentIndex == _questions.length - 1 ? 'Submit' : 'Next',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OptionButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const _OptionButton({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF7C4DFF) : const Color(0xFFEDE7F6),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          text,
          style: TextStyle(color: isSelected ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
