import 'package:flutter/material.dart';
import 'package:hackathon_app/color/app_colors.dart';

class RecomendationTask extends StatelessWidget {
  const RecomendationTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('For you', style: Theme.of(context).textTheme.labelMedium),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.violet300,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Short sessions Deep Read (7–10 minutes) & Based on your mood & schedule',
                  style: Theme.of(
                    context,
                  ).textTheme.labelMedium?.copyWith(color: Colors.white),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Image.asset(
                  'assets/icons/arrow.png',
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
