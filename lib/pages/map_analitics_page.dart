import 'package:flutter/material.dart';
import 'package:hackathon_app/services/auth_service.dart';
import 'package:hackathon_app/services/reading_progress_service.dart';

class MapAnaliticsPage extends StatefulWidget {
  const MapAnaliticsPage({super.key});

  @override
  State<MapAnaliticsPage> createState() => _MapAnaliticsPageState();
}

class _MapAnaliticsPageState extends State<MapAnaliticsPage> {
  Map<String, dynamic>? _user;
  bool _loadingUser = true;
  Future<void> _fetchUser() async {
    final user = await AuthService.getCurrentUser();

    if (!mounted) return;

    setState(() {
      _user = user;
      _loadingUser = false;
    });
  }

  String getDailyInsight() {
    final acc = ReadingProgressService.accuracyToday;

    if (acc >= 0.8) {
      return 'Excellent focus today. Your comprehension stayed consistent.';
    } else if (acc >= 0.5) {
      return 'Good effort. Try slowing down on complex sections.';
    } else {
      return 'Focus dipped today. Consider shorter sessions tomorrow.';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F2FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ================= HEADER =================
              // ================= HEADER =================
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/icons/bro.jpg', // sama dengan profile page
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _loadingUser
                            ? 'Hello!'
                            : 'Hello, ${_user?['name'] ?? 'User'}!',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        'Laser Focus Squad',
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall?.copyWith(color: Colors.black54),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Text(
                'Today Summary',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 12),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${ReadingProgressService.minutesReadToday} minutes focused',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    const SizedBox(height: 6),

                    Text(
                      '${ReadingProgressService.correctAnswersToday}'
                      ' / ${ReadingProgressService.questionsAnsweredToday} correct answers',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),

                    const SizedBox(height: 10),

                    LinearProgressIndicator(
                      value: ReadingProgressService.accuracyToday,
                      backgroundColor: Colors.grey.shade300,
                      color: const Color(0xFF7C4DFF),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Focus Level: ${ReadingProgressService.lastFocusLevel ?? "-"}',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      getDailyInsight(),
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.black54),
                    ),
                  ],
                ),
              ),
              // ================= WEEKLY RECAP =================
              Text(
                'Your Weekly Performance Recap',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 16),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _MiniStatCard(
                      value: '${ReadingProgressService.minutesReadToday}',
                      label: 'minutes of focus\ntoday',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _FocusTimeMeter(
                      minutes: ReadingProgressService.minutesReadToday,
                      targetMinutes: 45,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _MiniStatCard(
                      value: '${ReadingProgressService.articlesReadToday}',
                      label: 'articles completed\nin Deep Read',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // ================= FOCUS PERFORMANCE =================
              Text(
                'Your Focus Performance',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 12),

              const _FocusLevelBar(),

              const SizedBox(height: 30),

              // ================= DAILY FOCUS TIME =================
              Text(
                'Daily Focus Time',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 12),

              const _DailyFocusChart(),

              const SizedBox(height: 30),

              // ================= AI RECOMMENDATION =================
              Text(
                'AI Recommendation',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 12),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDE7F6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'To improve your focus performance, try committing to one fully distraction-free focus session and gradually extend its depth rather than switching between tasks.',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MiniStatCard extends StatelessWidget {
  final String value;
  final String label;

  const _MiniStatCard({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF7C4DFF),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _FocusTimeMeter extends StatelessWidget {
  final int minutes;
  final int targetMinutes;
  const _FocusTimeMeter({required this.minutes, required this.targetMinutes});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text('Focus Time', style: TextStyle(fontWeight: FontWeight.w600)),
          SizedBox(height: 8),
          Text(
            '${minutes ~/ 60}h ${minutes % 60}m',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF7C4DFF),
            ),
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: (minutes / targetMinutes).clamp(0, 1),
            color: const Color(0xFF7C4DFF),
            backgroundColor: const Color(0xFFE0E0E0),
          ),
          SizedBox(height: 4),
          Text('0 hour — 1 hour', style: TextStyle(fontSize: 10)),
        ],
      ),
    );
  }
}

class _FocusLevelBar extends StatelessWidget {
  const _FocusLevelBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          LinearProgressIndicator(
            value: 0.4,
            color: const Color(0xFF7C4DFF),
            backgroundColor: Colors.grey.shade300,
            minHeight: 14,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [Text('Level 2'), Text('Level 3'), Text('Level 4')],
          ),
        ],
      ),
    );
  }
}

class _DailyFocusChart extends StatelessWidget {
  const _DailyFocusChart();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          _DayBar(day: 'Mon', height: 40),
          _DayBar(day: 'Tue', height: 25),
          _DayBar(day: 'Wed', height: 50),
          _DayBar(day: 'Thu', height: 30),
          _DayBar(day: 'Fri', height: 70),
          _DayBar(day: 'Sat', height: 20),
          _DayBar(day: 'Sun', height: 45),
        ],
      ),
    );
  }
}

class _DayBar extends StatelessWidget {
  final String day;
  final double height;

  const _DayBar({required this.day, required this.height});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 14,
          height: height,
          decoration: BoxDecoration(
            color: const Color(0xFF7C4DFF),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(height: 6),
        Text(day, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
