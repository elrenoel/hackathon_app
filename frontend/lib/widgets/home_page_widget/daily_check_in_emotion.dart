import 'package:flutter/material.dart';
import 'package:hackathon_app/widgets/emotion_btn.dart';

class DailyCheckInEmotion extends StatefulWidget {
  const DailyCheckInEmotion({super.key});

  @override
  State<DailyCheckInEmotion> createState() => _DailyCheckInEmotionState();
}

class _DailyCheckInEmotionState extends State<DailyCheckInEmotion> {
  String? selectedEmotion;

  void toggleEmotion(String emotion) {
    setState(() {
      if (selectedEmotion == emotion) {
        selectedEmotion = null; // tekan 2x → mati
      } else {
        selectedEmotion = emotion; // pilih baru
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "How have things been today?",
          style: Theme.of(context).textTheme.headlineLarge,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10),

        // Emotion Buttons
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 12,
          runSpacing: 12,
          children: [
            emotionButton(
              text: 'Happy',
              color: Colors.lightGreenAccent,
              isSelected: selectedEmotion == 'Happy',
              onPressed: () => toggleEmotion('Happy'),
            ),
            emotionButton(
              text: 'Angry',
              color: Colors.redAccent,
              isSelected: selectedEmotion == 'Angry',
              onPressed: () => toggleEmotion('Angry'),
            ),
            emotionButton(
              text: 'Excited',
              color: Colors.purpleAccent,
              isSelected: selectedEmotion == 'Excited',
              onPressed: () => toggleEmotion('Excited'),
            ),
            emotionButton(
              text: 'Stressed',
              color: Colors.orangeAccent,
              isSelected: selectedEmotion == 'Stressed',
              onPressed: () => toggleEmotion('Stressed'),
            ),
            emotionButton(
              text: 'Sad',
              color: Colors.blueAccent,
              isSelected: selectedEmotion == 'Sad',
              onPressed: () => toggleEmotion('Sad'),
            ),
          ],
        ),

        // End Emotion Buttons
        SizedBox(height: 10),

        // Submit Button
        TextButton(
          onPressed: () {
            debugPrint('Button ditekan');
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.symmetric(horizontal: 100),
          ),
          child: Text(
            'Submit',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.white),
          ),
        ),

        // End Submit Button
      ],
    );
  }
}
