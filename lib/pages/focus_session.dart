import 'package:flutter/material.dart';
import 'package:hackathon_app/color/app_colors.dart';
import 'package:hackathon_app/models/blocked_app.dart';
import 'package:hackathon_app/models/focus_session_payload.dart';
import 'package:hackathon_app/pages/app_blocker_page.dart';
import 'package:hackathon_app/pages/timer_focus_session_page.dart';
import 'package:hackathon_app/widgets/block_app.dart';
import 'package:hackathon_app/widgets/input_new_goal_widget/duration_time_task.dart';
import 'package:hackathon_app/widgets/input_new_goal_widget/field_task_title.dart';
import 'package:hackathon_app/widgets/input_new_goal_widget/sub_task_section.dart';
import 'package:hackathon_app/models/sub_task.dart';

class FocusSession extends StatefulWidget {
  const FocusSession({super.key});

  @override
  State<FocusSession> createState() => _FocusSessionState();
}

class _FocusSessionState extends State<FocusSession> {
  String valueTaskTitle = '';
  int valueDurationHours = 0;
  int valueDurationMinutes = 0;
  int valueDurationSeconds = 0;
  List<SubTask> subTasks = [];
  final List<BlockedApp> blockedApps = [];

  bool get isFormValid {
    final durationInSeconds =
        (valueDurationHours * 3600) +
        (valueDurationMinutes * 60) +
        valueDurationSeconds;

    debugPrint('''
    VALIDATION:
    title: $valueTaskTitle
    duration: $durationInSeconds
    blockedApps: ${blockedApps.length}
    subTasks: ${subTasks.length}
    ''');

    return valueTaskTitle.trim().isNotEmpty &&
        durationInSeconds > 0 &&
        blockedApps.isNotEmpty &&
        subTasks.isNotEmpty;
  }

  void addBlockedApps(List<BlockedApp> apps) {
    setState(() {
      for (final app in apps) {
        if (!blockedApps.any((e) => e.name == app.name)) {
          blockedApps.add(app);
        }
      }
    });
  }

  void removeBlockedApp(BlockedApp app) {
    setState(() {
      blockedApps.remove(app);
    });
  }

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
            onPressed: isFormValid
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TimerFocusSessionPage(
                          payload: FocusSessionPayload(
                            taskTitle: valueTaskTitle,
                            duration: Duration(
                              hours: valueDurationHours,
                              minutes: valueDurationMinutes,
                              seconds: valueDurationSeconds,
                            ),
                            blockedApps: blockedApps
                                .map((e) => e.packageName)
                                .toList(),
                            subtasks: subTasks.map((e) => e.title).toList(),
                            source: FocusSource.focusSession,
                            needPermission: true, // 🔥 WAJIB
                          ),
                        ),
                      ),
                    );
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: isFormValid
                  ? AppColors.violet300
                  : AppColors.violet100,
              padding: const EdgeInsets.symmetric(vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),

            child: Text(
              'Start Session',
              style: Theme.of(
                context,
              ).textTheme.labelMedium?.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // ⬅️ PENTING
            children: [
              // ===== HEADER =====
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 16,
                ),
                child: Row(
                  children: [
                    BackButton(),
                    const SizedBox(width: 12),
                    Text(
                      'Focus Session',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 140),

                child: Column(
                  children: [
                    // ===== TASK TITLE =====
                    FieldTaskTitle(
                      onChanged: (value) => setState(() {
                        valueTaskTitle = value;
                      }),
                    ),

                    SizedBox(height: 16),

                    DurationTimeTask(
                      onChanged: (duration) {
                        setState(() {
                          valueDurationHours = duration.inHours;
                          valueDurationMinutes = duration.inMinutes % 60;
                          valueDurationSeconds = duration.inSeconds % 60;
                        });
                      },
                    ),

                    SizedBox(height: 16),

                    BlockApp(
                      blockedApps: blockedApps,
                      onAddPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AppBlockerPage(),
                          ),
                        );

                        if (result != null && result is List<BlockedApp>) {
                          addBlockedApps(result);
                        }
                      },
                      onRemove: removeBlockedApp,
                    ),

                    SizedBox(height: 16),
                    SubTaskSection(
                      onChanged: (value) {
                        setState(() {
                          subTasks = List<SubTask>.from(value);
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
