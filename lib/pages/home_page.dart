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
    return Padding(
      padding: const EdgeInsets.only(top: 50, right: 20, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(999),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(1, 1),
                      blurRadius: 3,
                      // ignore: deprecated_member_use
                      color: Colors.black.withOpacity(0.15),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: Image.asset('assets/icons/bro.jpg', fit: BoxFit.cover),
                ),
              ),
              SizedBox(width: 10),
              Text("Hi User!", style: Theme.of(context).textTheme.labelLarge),
            ],
          ),
          SizedBox(height: 30),
          Center(
            child: Column(
              children: [
                Text(
                  "☀️ Good Morning",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      // Daily Check in Emotion/Mood
                      DailyCheckInEmotion(),

                      //End Daily Check in Emotion/Mood
                      SizedBox(height: 15),

                      // List Todo Today
                      GoalsToday(),

                      // End List Todo today
                      SizedBox(height: 15),

                      RecomendationTask(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
