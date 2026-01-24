import 'package:flutter/material.dart';
import 'package:hackathon_app/pages/input_goal_page.dart';
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
    final todos = await TodoService.fetchTodos();

    if (!mounted) return;

    setState(() {
      goals = todos.map<Task>((todo) {
        return Task(
          id: todo['id'],
          title: todo['title'],
          durationTime: todo['duration'] ?? "25 min",
          startTime: DateTime.parse(
            todo['start_time'] ?? DateTime.now().toIso8601String(),
          ),
          reminder: todo['reminder'] ?? '',
          goalsDone: todo['is_done'] ?? false,
          subTasks: [],
        );
      }).toList();

      _loading = false;
    });
  }

  int get totalTodos => goals.length;

  int get doneTodos => goals.where((t) => t.goalsDone).length;

  double get progress {
    if (totalTodos == 0) return 0;
    return doneTodos / totalTodos;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ===== HEADER =====
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
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

            // ===== ADD TODO =====
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
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Progress Today',
                style: Theme.of(context).textTheme.labelLarge,
              ),

              const SizedBox(height: 6),

              LinearProgressIndicator(
                value: progress,
                minHeight: 8,
                borderRadius: BorderRadius.circular(8),
                backgroundColor: Colors.grey.shade300,
                valueColor: const AlwaysStoppedAnimation(Colors.black),
              ),

              const SizedBox(height: 6),

              Text(
                '$doneTodos / $totalTodos goals done',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
        ),

        // ===== LIST TODO =====
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

              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: Text(task.title)),
                      Expanded(child: Text(task.durationTime)),

                      Row(
                        children: [
                          // 🗑️ DELETE
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
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
                          // ✅ TOGGLE DONE / FOCUS
                          InkWell(
                            onTap: () async {
                              print('CLICKED TODO ID: ${task.id}');
                              final success = await TodoService.toggleTodo(
                                task.id,
                              );
                              if (success) {
                                _loadGoals();
                              }
                            },
                            child: Row(
                              children: [
                                Text(task.goalsDone ? 'Done' : 'Focus Now'),
                                const SizedBox(width: 6),
                                Icon(
                                  task.goalsDone
                                      ? Icons.check_circle
                                      : Icons.arrow_forward_ios,
                                  size: 16,
                                  color: task.goalsDone
                                      ? Colors.green
                                      : Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}
