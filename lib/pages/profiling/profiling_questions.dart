import 'package:flutter/material.dart';
import 'package:hackathon_app/color/app_colors.dart';
import 'package:hackathon_app/pages/profiling/profiling_calculate_result.dart';
import 'package:hackathon_app/widgets/step_indicator.dart';

class Question {
  final String title;
  final String question;
  final List<String> options;

  Question({
    required this.title,
    required this.question,
    required this.options,
  });
}

final List<Question> questions = [
  Question(
    title: 'Question 1',
    question:
        'When you start working on a task (studying, assignments, work), what usually happens?',
    options: [
      'I stay focused until I finish',
      'I get distracted for a bit, but I can refocus',
      'I get distracted and struggle to focus again',
    ],
  ),
  Question(
    title: 'Question 2',
    question:
        'When notifications or background noise pop up, how do they affect you?',
    options: [
      'They barely affect my focus',
      'They break my focus briefly',
      'They completely break my focus',
    ],
  ),
  Question(
    title: 'Question 3',
    question:
        'When your mind starts to wander while you’re working, what usually happens?',
    options: [
      'I notice it quickly and bring my focus back',
      ' I notice it after a while',
      'I usually don’t notice until my work is affected',
    ],
  ),
  Question(
    title: 'Question 4',
    question:
        'When you tell yourself “I’ll focus for X minutes,” what usually happens?',
    options: [
      'I stick to the plan',
      'I mostly stick to it, with a few pauses',
      'I rarely stick to it',
    ],
  ),
  Question(
    title: 'Question 5',
    question:
        'While you’re trying to focus, how often do other thoughts (plans or random ideas) pop up?',
    options: ['Rarely', 'Sometimes', 'Often'],
  ),
];

class ProfilingQuestions extends StatefulWidget {
  const ProfilingQuestions({super.key});

  @override
  State<ProfilingQuestions> createState() => _ProfilingQuestionsState();
}

class _ProfilingQuestionsState extends State<ProfilingQuestions> {
  int currentIndex = 0;
  final List<int?> answers = List.filled(5, null);

  void next() {
    if (answers[currentIndex] == null) return;

    if (currentIndex < questions.length - 1) {
      setState(() => currentIndex++);
    } else {
      final result = answersUser();
      debugPrint('Answers: $result}');
    }
  }

  void back() {
    if (currentIndex > 0) {
      setState(() => currentIndex--);
    }
  }

  List<Map<String, dynamic>> answersUser() {
    return List.generate(questions.length, (index) {
      final selectedIndex = answers[index];

      return {
        'question': index + 1,
        'answers': selectedIndex != null
            ? questions[index].options[selectedIndex]
            : null,
      };
    });
  }

  void finish() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfilingCalculateResult()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final q = questions[currentIndex];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        spacing: 17,
        children: [
          SizedBox(height: 30),
          Row(
            children: [
              BackButton(color: AppColors.black5),
              Text(
                q.title,
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium?.copyWith(color: AppColors.black5),
              ),
            ],
          ),
          stepIndicator(currentIndex + 1, 5),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                right: 16,
                left: 16,
                bottom: 32,
                top: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  Text(
                    q.question,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 24),

                  ...List.generate(q.options.length, (i) {
                    final selected = answers[currentIndex] == i;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: selected
                                ? Colors.deepPurple
                                : Colors.deepPurple.shade100,
                            foregroundColor: selected
                                ? Colors.white
                                : Colors.deepPurple,
                            padding: EdgeInsets.symmetric(vertical: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            setState(() => answers[currentIndex] = i);
                          },
                          child: Text(q.options[i]),
                        ),
                      ),
                    );
                  }),

                  Spacer(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10,
                    children: [
                      if (currentIndex > 0)
                        Expanded(
                          child: OutlinedButton(
                            onPressed: back,
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 18),
                            ),
                            child: Text('Back'),
                          ),
                        ),

                      Expanded(
                        child: FilledButton(
                          onPressed: currentIndex == questions.length - 1
                              ? finish
                              : next,
                          style: FilledButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 18),
                          ),
                          child: Text(
                            currentIndex == questions.length - 1
                                ? 'Finish'
                                : 'Next',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
