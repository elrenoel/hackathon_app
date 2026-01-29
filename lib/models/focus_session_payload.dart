class FocusSessionPayload {
  final String taskTitle;
  final Duration duration;
  final List<String> subtasks;

  /// ⬇️ hanya dipakai kalau focusSession
  final List<String> blockedApps;

  /// ⬇️ sumber page
  final FocusSource source;

  const FocusSessionPayload({
    required this.taskTitle,
    required this.duration,
    required this.subtasks,
    required this.source,
    this.blockedApps = const [],
    required bool needPermission,
  });

  bool get needPermission => source == FocusSource.focusSession;
}

enum FocusSource { todo, focusSession }
