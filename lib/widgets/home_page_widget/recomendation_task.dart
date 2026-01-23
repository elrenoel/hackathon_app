import 'package:flutter/material.dart';

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
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                offset: const Offset(1, 1),
                blurRadius: 6,
                // ignore: deprecated_member_use
                color: Colors.black.withOpacity(0.15),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Short sessions Deep Read (7–10 minutes) & Based on your mood & schedule',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Image.asset(
                  'assets/icons/arrow.png',
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
