import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hackathon_app/models/focus_session_payload.dart';
import 'package:hackathon_app/services/focus_services.dart';
import 'package:hackathon_app/services/permission_services.dart';
import 'package:hackathon_app/widgets/focus_permission_overlay.dart';
import 'package:hackathon_app/widgets/permission_sheet.dart';

class TimerFocusSessionPage extends StatefulWidget {
  final FocusSessionPayload payload;

  const TimerFocusSessionPage({super.key, required this.payload});

  @override
  State<TimerFocusSessionPage> createState() => _TimerFocusSessionPageState();
}

class _TimerFocusSessionPageState extends State<TimerFocusSessionPage>
    with WidgetsBindingObserver {
  bool isCountdown = true;

  final taskController = TextEditingController();
  final durationController = TextEditingController(text: '01:20');

  String? selectedSubtask;

  Timer? _timer;
  late Duration currentDuration;
  bool isRunning = false;

  late Map<String, bool> subtaskStatus;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    print("🔥 PAYLOAD RAW: ${widget.payload}");
    print("🔥 PAYLOAD SUBTASKS: ${widget.payload.subtasks}");

    currentDuration = widget.payload.duration;
    subtaskStatus = {for (final t in widget.payload.subtasks) t: false};
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed && isRunning) {
      final status = await PermissionService.check();

      final allGranted = status.values.every((e) => e);

      if (!allGranted) {
        _handlePermissionRevoked();
      }
    }
  }

  void _handlePermissionRevoked() async {
    // stop timer
    _timer?.cancel();
    _timer = null;

    // stop native focus
    await FocusService.stopFocus();

    if (!mounted) return;

    setState(() => isRunning = false);

    // show UX feedback
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('Focus paused'),
        content: const Text(
          'One or more required permissions were disabled. '
          'Focus session has been stopped.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void start() async {
    // 🔥 kalau dari TODO → langsung start timer
    if (!widget.payload.needPermission) {
      startTimer();
      return;
    }

    // ===== logic lama (focus session) =====
    final status = await PermissionService.check();
    final allGranted = status.values.every((e) => e);

    if (!allGranted) {
      if (!mounted) return;

      final agreed = await showPermissionOverlay(context);
      if (!agreed) return;

      final ok = await ensurePermissions(context);
      if (!ok) return;
    }

    await FocusService.startFocus(widget.payload.blockedApps);
    startTimer();
  }

  void startTimer() {
    if (isRunning) return;

    setState(() => isRunning = true);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (isCountdown) {
          if (currentDuration.inSeconds <= 0) {
            _timer?.cancel();
            _timer = null;
            setState(() => isRunning = false);
            if (widget.payload.needPermission) {
              FocusService.stopFocus();
            } // fire-and-forget
          } else {
            currentDuration -= const Duration(seconds: 1);
          }
        } else {
          currentDuration += const Duration(seconds: 1);
        }
      });
    });
  }

  void stop() async {
    _timer?.cancel();
    _timer = null;

    // 🔥 STOP FOCUS MODE (native)
    if (widget.payload.needPermission) {
      await FocusService.stopFocus();
    }

    setState(() => isRunning = false);
  }

  void switchMode(bool countdown) {
    stop();
    setState(() {
      isCountdown = countdown;
      currentDuration = const Duration(minutes: 25);
    });
  }

  String formatDuration(Duration d) {
    final hours = d.inHours.toString().padLeft(2, '0');
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');

    return '$hours:$minutes:$seconds';
  }

  Future<bool> ensurePermissions(BuildContext context) async {
    final status = await PermissionService.check();

    if (status.values.every((e) => e)) return true;

    await showModalBottomSheet(
      context: context,
      builder: (_) => PermissionSheet(status: status),
    );

    final newStatus = await PermissionService.check();
    return newStatus.values.every((e) => e); // 🔒 STRICT
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Focus Session'),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // TIMER DISPLAY
            Center(
              child: Column(
                children: [
                  Text(
                    formatDuration(currentDuration),
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),

                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: isRunning ? stop : start,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 36,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      isRunning ? 'STOP' : 'START FOCUS',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // COUNTDOWN / TIMER SWITCH
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChoiceChip(
                  label: const Text('COUNTDOWN'),
                  selected: isCountdown,
                  onSelected: (_) => switchMode(true),
                ),
                SizedBox(width: 5),
                ChoiceChip(
                  label: const Text('TIMER'),
                  selected: !isCountdown,
                  onSelected: (_) => switchMode(false),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // TASK TITLE
            const Text('Task Title'),
            const SizedBox(height: 6),
            Text(
              widget.payload.taskTitle,
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const SizedBox(height: 16),

            // ESTIMATED DURATION
            const Text('Estimated Duration'),
            const SizedBox(height: 6),
            Text(
              formatDuration(widget.payload.duration),
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: 16),

            // SUBTASK
            if (widget.payload.subtasks.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Text('Subtasks'),
              ...subtaskStatus.entries.map((entry) {
                return CheckboxListTile(
                  title: Text(entry.key),
                  value: entry.value,
                  onChanged: (v) {
                    setState(() {
                      subtaskStatus[entry.key] = v ?? false;
                    });
                  },
                );
              }),
            ],
          ],
        ),
      ),
    );
  }
}
