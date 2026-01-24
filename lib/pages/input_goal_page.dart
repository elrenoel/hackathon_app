// import 'dart:convert';
import 'package:hackathon_app/color/app_colors.dart';
import 'package:hackathon_app/services/todo_service.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_app/widgets/input_new_goal_widget/duration_time_task.dart';
import 'package:hackathon_app/widgets/input_new_goal_widget/field_task_title.dart';
import 'package:hackathon_app/widgets/input_new_goal_widget/reminder_task.dart';
import 'package:hackathon_app/widgets/input_new_goal_widget/start_time_task.dart';
import 'package:hackathon_app/widgets/input_new_goal_widget/sub_task_section.dart';

class Task {
  final int id;
  final String title;
  final String durationTime;
  final DateTime startTime;
  final List<SubTask> subTasks;
  final String reminder;
  final bool goalsDone;

  Task({
    required this.id,
    required this.title,
    required this.durationTime,
    required this.startTime,
    required this.subTasks,
    required this.reminder,
    required this.goalsDone,
  });
}

class SubTask {
  final String title;
  bool isDone;

  SubTask({required this.title, this.isDone = false});

  Map<String, dynamic> toJson() => {'title': title, 'isDone': isDone};
}

class InputGoalPage extends StatefulWidget {
  const InputGoalPage({super.key});

  @override
  State<InputGoalPage> createState() => _InputGoalPageState();
}

class _InputGoalPageState extends State<InputGoalPage> {
  String valueTaskTitle = '';
  int? valueDurationHours;
  int? valueDurationMinutes;
  // final TextEditingController startTimeController = TextEditingController();
  DateTime? _startTime;
  String? valueReminder;
  List<SubTask> subTasks = [];
  List<Map<String, dynamic>> tasks = [];
  bool goalsDone = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFF5F5F5),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 20,
              spreadRadius: 2,
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.15),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: ElevatedButton(
            onPressed: () async {
              if (valueTaskTitle.isEmpty) return;

              final duration =
                  '${valueDurationHours ?? 0} hr : ${valueDurationMinutes ?? 0} min';

              final success = await TodoService.addTodo(
                title: valueTaskTitle,
                duration: duration,
                startTime: _startTime ?? DateTime.now(),
                reminder: valueReminder,
              );

              if (!mounted) return;

              if (success) {
                Navigator.pop(context, true); // ⬅️ PENTING
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Gagal menyimpan todo")),
                );
              }
            },

            //   setState(() {
            //     tasks.add({
            //       'title': valueTaskTitle,
            //       'durationTime':
            //           '${valueDurationHours ?? 0} hr : ${valueDurationMinutes ?? 0} min',
            //       'startTime': (_startTime ?? DateTime.now()).toIso8601String(),
            //       'subTasks': subTasks.map((s) => s.toJson()).toList(),
            //       'reminder': valueReminder,
            //       'goalsDone': goalsDone,
            //     });

            //     // ignore: avoid_print
            //     print(const JsonEncoder.withIndent('  ').convert(tasks));
            //   });
            // },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.violet300,
              padding: EdgeInsets.symmetric(vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(12),
              ),
            ),
            child: Text(
              'Add New Goal',
              style: Theme.of(
                context,
              ).textTheme.labelMedium?.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 140),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // ⬅️ PENTING
            children: [
              // ===== HEADER =====
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          // ignore: deprecated_member_use
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Image.asset('assets/icons/backbtn.png'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'New Goal',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ===== TASK TITLE =====
              FieldTaskTitle(onChanged: (value) => valueTaskTitle = value),

              const SizedBox(height: 16),

              // ===== DURATION =====
              DurationTimeTask(
                onChangedHours: (value) => valueDurationHours = value,
                onChangedMinutes: (value) => valueDurationMinutes = value,
              ),

              const SizedBox(height: 16),

              // ===== START TIME =====
              StartTimeTask(
                selectedTime: _startTime,
                onChanged: (value) {
                  setState(() {
                    _startTime = value;
                  });
                },
              ),

              const SizedBox(height: 16),

              // ===== REMINDER =====
              ReminderTask(onChangedReminder: (value) => valueReminder = value),

              const SizedBox(height: 20),

              // ===== SUBTASK =====
              SubTaskSection(onChanged: (value) => subTasks = value),
            ],
          ),
        ),
      ),
    );
  }
}
