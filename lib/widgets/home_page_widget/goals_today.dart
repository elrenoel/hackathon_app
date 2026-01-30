import 'package:flutter/material.dart';
import 'package:hackathon_app/color/app_colors.dart';
import 'package:hackathon_app/models/focus_session_payload.dart';
import 'package:hackathon_app/models/sub_task.dart';
import 'package:hackathon_app/pages/input_goal_page.dart';
import 'package:hackathon_app/pages/timer_focus_session_page.dart';
import 'package:hackathon_app/services/todo_service.dart';

class GoalsToday extends StatefulWidget {
  const GoalsToday({super.key});

  @override
  State<GoalsToday> createState() => _GoalsTodayState();
}

class _GoalsTodayState extends State<GoalsToday> {
  // 🔹 STATE
  List<Task> goals = [];
  bool _loading = true;

  // 🔹 LOAD DATA SAAT WIDGET DIBUAT
  @override
  void initState() {
    super.initState();
    _loadGoals();
  }

  //AMBIL
  Future<void> _loadGoals() async {
    setState(() {
      _loading = true;
    });

    final todos = await TodoService.fetchTodos();

    if (!mounted) return;

    setState(() {
      goals = todos.map<Task>((todo) {
        return Task(
          id: todo['id'],
          title: todo['title'],
          durationTime: todo['duration'] ?? '25 min',
          startTime: DateTime.parse(
            todo['start_time'] ?? DateTime.now().toIso8601String(),
          ),
          reminder: todo['reminder'] ?? '',
          goalsDone: todo['is_done'] ?? false,
          subTasks: (todo['subtasks'] as List? ?? [])
              .map((s) => SubTask.fromJson(s))
              .toList(),
        );
      }).toList();

      print("GOALS LENGTH: ${goals.length}");

      _loading = false; // 🔥 INI KUNCI
    });
  }

  int get totalTodos => goals.length;

  int get doneTodos => goals.where((t) => t.goalsDone).length;

  double get progress {
    if (totalTodos == 0) return 0;
    return doneTodos / totalTodos;
  }

  Duration _parseDuration(String value) {
    final text = value.toLowerCase();

    int hours = 0;
    int minutes = 0;
    int seconds = 0;

    final hourMatch = RegExp(r'(\d+)\s*(jam|hour|hours|h)').firstMatch(text);
    if (hourMatch != null) {
      hours = int.parse(hourMatch.group(1)!);
    }

    final minuteMatch = RegExp(
      r'(\d+)\s*(menit|min|minutes|m)',
    ).firstMatch(text);
    if (minuteMatch != null) {
      minutes = int.parse(minuteMatch.group(1)!);
    }

    final secondMatch = RegExp(
      r'(\d+)\s*(detik|sec|seconds|s)',
    ).firstMatch(text);
    if (secondMatch != null) {
      seconds = int.parse(secondMatch.group(1)!);
    }

    // fallback default
    if (hours == 0 && minutes == 0 && seconds == 0) {
      minutes = 25;
    }

    return Duration(hours: hours, minutes: minutes, seconds: seconds);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // ===== HEADER =====
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'What do you want to get done today?',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      'for good focus max 3–5 item todo list today',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
              ),

              IconButton(
                onPressed: () async {
                  final result = await Navigator.push<bool>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const InputGoalPage(),
                    ),
                  );

                  if (result == true) {
                    _loadGoals(); // 🔥 reload dari backend
                  }
                },
                icon: Image.asset('assets/icons/add.png'),
              ),
            ],
          ),

          const SizedBox(height: 10),

          if (_loading)
            const Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: goals.length,
              itemBuilder: (context, index) {
                final task = goals[index];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: !task.goalsDone
                            ? AppColors.violet300
                            : AppColors.green,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 4,
                              children: [
                                Text(
                                  task.title,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                Row(
                                  spacing: 2,
                                  children: [
                                    Icon(Icons.timer_outlined, size: 16),
                                    Text(
                                      task.durationTime,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.labelSmall,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Color.fromARGB(255, 75, 75, 75),
                            ),
                            onPressed: () async {
                              final confirm = await showDialog<bool>(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: const Text("Delete todo?"),
                                  content: const Text(
                                    "This action cannot be undone",
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, false),
                                      child: const Text("Cancel"),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, true),
                                      child: const Text("Delete"),
                                    ),
                                  ],
                                ),
                              );

                              if (confirm == true) {
                                final success = await TodoService.deleteTodo(
                                  task.id,
                                );
                                if (success) _loadGoals();
                              }
                            },
                          ),

                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => TimerFocusSessionPage(
                                    payload: FocusSessionPayload(
                                      taskTitle: task.title,
                                      duration: _parseDuration(
                                        task.durationTime,
                                      ),
                                      subtasks: task.subTasks
                                          .map((e) => e.title)
                                          .toList(),
                                      needPermission: false,
                                      source: FocusSource.todo,
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              task.goalsDone ? 'Done' : 'Focus Now',
                              style: Theme.of(context).textTheme.labelMedium
                                  ?.copyWith(
                                    color: task.goalsDone
                                        ? AppColors.green
                                        : AppColors.violet300,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
