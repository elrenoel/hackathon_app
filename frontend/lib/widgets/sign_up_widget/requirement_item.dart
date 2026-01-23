import 'package:flutter/material.dart';
import 'package:hackathon_app/color/app_colors.dart';

class RequirementItem extends StatelessWidget {
  final String text;
  final bool isValid;

  const RequirementItem(this.text, this.isValid, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(
            isValid ? Icons.check_circle : Icons.radio_button_unchecked,
            size: 16,
            color: isValid ? AppColors.green : AppColors.gray200,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: isValid ? AppColors.green : AppColors.gray200,
            ),
          ),
        ],
      ),
    );
  }
}
