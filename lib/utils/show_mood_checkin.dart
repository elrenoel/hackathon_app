import 'package:flutter/material.dart';
// import 'package:hackathon_app/widgets/home_page_widget/daily_check_in_emotion.dart';

Future<void> showMoodCheckIn(BuildContext context) async {
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: false,
    enableDrag: false,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => const Padding(
      padding: EdgeInsets.all(16),
      // child: DailyCheckInEmotion(),
    ),
  );
}
