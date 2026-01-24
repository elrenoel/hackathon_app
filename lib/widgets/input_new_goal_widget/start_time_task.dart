import 'package:flutter/material.dart';
import 'package:hackathon_app/color/app_colors.dart' show AppColors;

class StartTimeTask extends StatelessWidget {
  final DateTime? selectedTime;
  final ValueChanged<DateTime> onChanged;

  const StartTimeTask({super.key, this.selectedTime, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final displayText = selectedTime == null
        ? ''
        : '${selectedTime!.hour.toString().padLeft(2, '0')}:'
              '${selectedTime!.minute.toString().padLeft(2, '0')}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Start Time', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 10),
        TextField(
          readOnly: true,
          controller: TextEditingController(text: displayText),
          onTap: () async {
            final time = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );

            if (time != null) {
              final now = DateTime.now();
              final pickedDateTime = DateTime(
                now.year,
                now.month,
                now.day,
                time.hour,
                time.minute,
              );

              onChanged(pickedDateTime);
            }
          },
          decoration: InputDecoration(
            hintText: 'hh:mm',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.violet300),
            ),
          ),
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
    );
  }
}
