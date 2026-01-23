import 'dart:async';
import 'package:flutter/material.dart';

class FocusTimer extends StatefulWidget {
  final int hours;
  final int minutes;

  const FocusTimer({super.key, required this.hours, required this.minutes});

  @override
  State<FocusTimer> createState() => _FocusTimerState();
}

class _FocusTimerState extends State<FocusTimer> {
  late Duration duration;
  Timer? timer;
  bool isRunning = false; // default timer belum jalan

  @override
  void initState() {
    super.initState();
    duration = Duration(hours: widget.hours, minutes: widget.minutes);
  }

  void startTimer() {
    timer?.cancel(); // pastikan timer lama dihentikan
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (duration.inSeconds > 0 && isRunning) {
        setState(() {
          duration -= const Duration(seconds: 1);
        });
      } else if (duration.inSeconds == 0) {
        timer?.cancel();
        setState(() {
          isRunning = false;
        });
      }
    });
  }

  void toggleTimer() {
    if (isRunning) {
      // pause
      setState(() {
        isRunning = false;
      });
    } else {
      // play
      setState(() {
        isRunning = true;
      });
      startTimer();
    }
  }

  void resetTimer() {
    timer?.cancel();
    setState(() {
      duration = Duration(hours: widget.hours, minutes: widget.minutes);
      isRunning = false;
    });
  }

  String twoDigits(int n) => n.toString().padLeft(2, '0');

  String formatDuration(Duration d) {
    final h = twoDigits(d.inHours);
    final m = twoDigits(d.inMinutes.remainder(60));
    final s = twoDigits(d.inSeconds.remainder(60));
    return "$h : $m : $s";
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Focus Section'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              formatDuration(duration),
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Play / Pause
                IconButton(
                  icon: Icon(isRunning ? Icons.pause : Icons.play_arrow),
                  iconSize: 36,
                  onPressed: toggleTimer,
                ),
                const SizedBox(width: 20),
                // Stop / Reset
                IconButton(
                  icon: const Icon(Icons.stop),
                  iconSize: 36,
                  onPressed: resetTimer,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
