import 'package:flutter/material.dart';
import 'package:hackathon_app/color/app_colors.dart';
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

                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: !task.goalsDone
                          ? AppColors.violet300
                          : AppColors.green,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 20,
                      children: [
                        Expanded(
                          child: Text(
                            task.title,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 2,
                            children: [
                              Icon(Icons.timer_outlined),
                              Text(
                                task.durationTime,
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ],
                          ),
                        ),

                        TextButton(
                          onPressed: () {},
                          child: !task.goalsDone
                              ? Text(
                                  'Focus Now',
                                  style: Theme.of(context).textTheme.labelSmall
                                      ?.copyWith(color: AppColors.violet300),
                                )
                              : Text(
                                  'Done',
                                  style: Theme.of(context).textTheme.labelSmall
                                      ?.copyWith(color: AppColors.green),
                                ),
                        ),
                      ],
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
