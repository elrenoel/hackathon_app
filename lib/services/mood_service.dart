class MoodService {
  static String? _todayMood;
  static DateTime? _lastCheckIn;

  static bool hasCheckedInToday() {
    if (_lastCheckIn == null) return false;

    final now = DateTime.now();
    return _lastCheckIn!.year == now.year &&
        _lastCheckIn!.month == now.month &&
        _lastCheckIn!.day == now.day;
  }

  static void saveMood(String mood) {
    _todayMood = mood;
    _lastCheckIn = DateTime.now();
  }

  static String get todayMood => _todayMood ?? 'Balanced';
}
