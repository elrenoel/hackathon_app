import 'package:flutter/material.dart';
import 'package:hackathon_app/color/app_colors.dart';
import 'package:hackathon_app/widgets/home_page_widget/daily_check_in_emotion.dart';
// import 'package:hackathon_app/utils/show_mood_checkin.dart';
import 'package:hackathon_app/widgets/home_page_widget/goals_today.dart';
import 'package:hackathon_app/widgets/home_page_widget/recomendation_task.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hackathon_app/pages/welcome_page.dart';
import 'package:hackathon_app/services/auth_service.dart';

class HomePage extends StatefulWidget {
  final VoidCallback onMoodSubmitted;
  const HomePage({super.key, required this.onMoodSubmitted});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic>? _user;
  bool _loadingUser = true;

  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  Future<void> _fetchUser() async {
    final user = await AuthService.getCurrentUser();

    if (!mounted) return;

    setState(() {
      _user = user;
      _loadingUser = false;
    });
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("access_token"); // ⚠️ HARUS SAMA KEY-NYA

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const WelcomePage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, right: 20, left: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: _logout,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(999),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(1, 1),
                          blurRadius: 3,
                          color: Colors.black.withValues(alpha: 0.15),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: Image.asset(
                        'assets/icons/bro.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 2,
                  children: [
                    Text(
                      _loadingUser
                          ? "Loading..."
                          : "Hi ${_user?['name'] ?? 'User'}!",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(
                      'Laser Focus Squad',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.violet300,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 30),
            Center(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        // Daily Check in Emotion/Mood
                        DailyCheckInEmotion(onSubmit: widget.onMoodSubmitted),
                        // ElevatedButton(
                        //   onPressed: () {
                        //     showMoodCheckIn(context);
                        //   },
                        //   child: const Text("Daily Mood Check-in"),
                        // ),

                        //End Daily Check in Emotion/Mood
                        SizedBox(height: 15),

                        // List Todo Today
                        GoalsToday(),

                        // End List Todo today
                        SizedBox(height: 15),

                        RecomendationTask(),

                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
