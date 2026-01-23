import 'package:flutter/material.dart';
import 'package:hackathon_app/color/app_colors.dart';

Widget stepIndicator(int step, int countStep) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List.generate(countStep, (index) {
      final isActive = step >= index + 1;

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.5),
        child: Container(
          width: 30,
          height: 6,
          decoration: BoxDecoration(
            color: isActive ? AppColors.violet200 : AppColors.gray200,
            borderRadius: BorderRadius.circular(99),
          ),
        ),
      );
    }),
  );
}
