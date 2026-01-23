import 'package:flutter/material.dart';
import 'package:hackathon_app/widgets/home_page_widget/daily_check_in_emotion.dart';
import 'package:hackathon_app/widgets/home_page_widget/goals_today.dart';
import 'package:hackathon_app/widgets/home_page_widget/recomendation_task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final width = media.size.width;
    final isTablet = width >= 600;

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: isTablet ? 40 : 20,
          vertical: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// HEADER
            Row(
              children: [
                Container(
                  width: isTablet ? 70 : 50,
                  height: isTablet ? 70 : 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(999),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(1, 1),
                        blurRadius: 3,
                        // ignore: deprecated_member_use
                        color: Colors.black.withOpacity(0.15),
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
                const SizedBox(width: 12),
                Text(
                  "Hi User!",
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontSize: isTablet ? 20 : null,
                  ),
                ),
              ],
            ),

            SizedBox(height: isTablet ? 40 : 30),

            /// BODY
            Center(
              child: Column(
                children: [
                  Text(
                    "☀️ Good Morning",
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontSize: isTablet ? 16 : null,
                    ),
                  ),
                  const SizedBox(height: 12),

                  /// CONTENT
                  Column(
                    children: const [
                      DailyCheckInEmotion(),
                      SizedBox(height: 15),
                      GoalsToday(),
                      SizedBox(height: 15),
                      RecomendationTask(),
                    ],
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
