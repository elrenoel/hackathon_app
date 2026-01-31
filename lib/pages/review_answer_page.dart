import 'package:flutter/material.dart';
import 'package:hackathon_app/services/reading_progress_service.dart';
import 'success_page.dart';
import 'package:hackathon_app/models/question_models.dart';

class ReviewAnswerPage extends StatefulWidget {
  final List<Question> questions;
  final List<UserAnswer> userAnswers;

  const ReviewAnswerPage({
    super.key,
    required this.questions,
    required this.userAnswers,
  });

  @override
  State<ReviewAnswerPage> createState() => _ReviewAnswerPageState();
}

class _ReviewAnswerPageState extends State<ReviewAnswerPage> {
  late List<bool> _showExplanation;

  @override
  void initState() {
    super.initState();
    _showExplanation = List.generate(widget.questions.length, (_) => false);
  }

  // ================= LOGIC =================

  bool _isCorrect(Question q, UserAnswer a) {
    if (q.isInput) {
      return a.textAnswer != null && a.textAnswer!.trim().isNotEmpty;
    }
    return a.selectedOption == q.correctIndex;
  }

  int calculateScore() {
    int score = 0;
    for (int i = 0; i < widget.questions.length; i++) {
      if (_isCorrect(widget.questions[i], widget.userAnswers[i])) {
        score++;
      }
    }
    return score;
  }

  String getFocusLevel(int score, int total) {
    final ratio = score / total;
    if (ratio >= 0.8) return 'Laser Focus';
    if (ratio >= 0.5) return 'Balanced Focus';
    return 'Scattered Focus';
  }

  String getFocusInsight(String level) {
    switch (level) {
      case 'Laser Focus':
        return 'Excellent focus. You captured both main ideas and details with clarity.';
      case 'Balanced Focus':
        return 'Good comprehension, but some details were missed. Try slowing down on denser sections.';
      default:
        return 'Your focus drifted during reading. Consider shorter sessions with fewer distractions.';
    }
  }

  String getDummyExplanation(int index) {
    switch (index) {
      case 0:
        return 'The author was not worried about brain capacity, but about doing things imperfectly due to perfectionism.';
      case 1:
        return 'Growing up with two languages showed the author that learning multiple languages is natural.';
      default:
        return 'Your answer was too general. The text emphasizes specific personal and professional benefits.';
    }
  }

  // ================= UI =================

  @override
  Widget build(BuildContext context) {
    final score = calculateScore();
    final total = widget.questions.length;
    final focusLevel = getFocusLevel(score, total);
    final insight = getFocusInsight(focusLevel);

    return Scaffold(
      appBar: AppBar(title: const Text('Review Answers')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // ===== FINAL SCORE =====
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: const Color(0xFFEDE7F6),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Final Score',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '$score / $total correct',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF7C4DFF),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Focus Level: $focusLevel',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    insight,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.black54),
                  ),
                ],
              ),
            ),

            // ===== ANSWERS =====
            Expanded(
              child: ListView.builder(
                itemCount: widget.questions.length,
                itemBuilder: (_, index) {
                  final q = widget.questions[index];
                  final a = widget.userAnswers[index];
                  final correct = _isCorrect(q, a);

                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: correct
                          ? const Color(0xFFE8F5E9)
                          : const Color(0xffffebee),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: correct ? Colors.green : Colors.red,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Q${index + 1}: ${q.question}',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(a.textAnswer ?? q.options![a.selectedOption ?? 0]),
                        const SizedBox(height: 10),

                        if (!correct && !q.isInput) ...[
                          Text(
                            'Correct answer: ${q.options![q.correctIndex!]}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(height: 12),

                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _showExplanation[index] =
                                    !_showExplanation[index];
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEDE7F6),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  const Text('🤖'),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      _showExplanation[index]
                                          ? 'Hide explanation'
                                          : 'Why is this wrong?',
                                      style: const TextStyle(
                                        color: Color(0xFF7C4DFF),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    _showExplanation[index]
                                        ? Icons.expand_less
                                        : Icons.expand_more,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          if (_showExplanation[index]) ...[
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(getDummyExplanation(index)),
                            ),
                          ],
                        ],
                      ],
                    ),
                  );
                },
              ),
            ),

            // ===== FINISH =====
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  ReadingProgressService.addReadingSession(
                    minutes: 10,
                    questions: widget.questions.length,
                    correctAnswers: score,
                    focusLevel: focusLevel,
                  );

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const SuccessPage()),
                    (route) => false,
                  );
                },
                child: const Text('Finish Review'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
