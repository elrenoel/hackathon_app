import 'package:flutter/material.dart';
import 'package:hackathon_app/color/app_colors.dart';

class FieldTaskTitle extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const FieldTaskTitle({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Task Title', style: Theme.of(context).textTheme.headlineMedium),
        SizedBox(height: 10),
        TextField(
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: 'Enter Task Title',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.violet300),
            ),
          ),
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
    );
  }
}
