class ReadingProgressService {
  static int minutesReadToday = 0;
  static int articlesReadToday = 0;
  static int questionsAnsweredToday = 0;
  static int correctAnswersToday = 0;
  static String? lastFocusLevel;

  static void addReadingSession({
    required int minutes,
    required int questions,
    required int correctAnswers,
    required String focusLevel,
  }) {
    minutesReadToday += minutes;
    questionsAnsweredToday += questions;
    correctAnswersToday += correctAnswers;
    lastFocusLevel = focusLevel;
    articlesReadToday += 1;
  }

  static void resetToday() {
    minutesReadToday = 0;
    articlesReadToday = 0;
  }

  static void addQuestionsAnswered(int count) {
    questionsAnsweredToday += count;
  }
}
