class FocusSessionPayload {
  final String taskTitle;
  final Duration duration;
  final List<String> blockedApps;
  final List<String> subtasks;

  FocusSessionPayload({
    required this.taskTitle,
    required this.duration,
    required this.blockedApps,
    required this.subtasks,
  });
}
