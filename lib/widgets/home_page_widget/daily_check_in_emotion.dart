import 'package:flutter/material.dart';
import 'package:hackathon_app/color/app_colors.dart';
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
        selectedEmotion = null;
      } else {
        selectedEmotion = emotion;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        children: [
          Text(
            "How are you feeling today?",
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),

          // Emotion Buttons
          Wrap(
            spacing: 5,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: [
              emotionButton(
                assetPath: 'assets/icons/mood2.png',
                isSelected: selectedEmotion == 'Calm',
                onPressed: () {
                  setState(() {
                    selectedEmotion = 'Calm';
                  });
                },
              ),
              emotionButton(
                assetPath: 'assets/icons/mood3.png',
                isSelected: selectedEmotion == 'Sad',
                onPressed: () {
                  setState(() {
                    selectedEmotion = 'Sad';
                  });
                },
              ),
              emotionButton(
                assetPath: 'assets/icons/mood4.png',
                isSelected: selectedEmotion == 'Angry',
                onPressed: () {
                  setState(() {
                    selectedEmotion = 'Angry';
                  });
                },
              ),
              emotionButton(
                assetPath: 'assets/icons/mood7.png',
                isSelected: selectedEmotion == 'Happy',
                onPressed: () {
                  setState(() {
                    selectedEmotion = 'Happy';
                  });
                },
              ),
              emotionButton(
                assetPath: 'assets/icons/mood5.png',
                isSelected: selectedEmotion == 'Tired',
                onPressed: () {
                  setState(() {
                    selectedEmotion = 'Tired';
                  });
                },
              ),
              emotionButton(
                assetPath: 'assets/icons/mood6.png',
                isSelected: selectedEmotion == 'Stress',
                onPressed: () {
                  setState(() {
                    selectedEmotion = 'Stress';
                  });
                },
              ),
              emotionButton(
                assetPath: 'assets/icons/mood1.png',
                isSelected: selectedEmotion == 'Badmood',
                onPressed: () {
                  setState(() {
                    selectedEmotion = 'Badmood';
                  });
                },
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
              backgroundColor: AppColors.violet300,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.symmetric(horizontal: 100),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Text(
                'Submit',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.white),
              ),
            ),
          ),

          // End Submit Button
        ],
      ),
    );
  }
}
