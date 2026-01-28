class ReadingProgressService {
  static int minutesReadToday = 0;
  static int articlesReadToday = 0;

  static void addReadingSession({required int minutes}) {
    minutesReadToday += minutes;
    articlesReadToday += 1;
  }

  static void resetToday() {
    minutesReadToday = 0;
    articlesReadToday = 0;
  }
}
