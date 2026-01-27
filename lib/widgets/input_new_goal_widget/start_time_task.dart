import 'package:flutter/cupertino.dart';
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
        : TimeOfDay.fromDateTime(selectedTime!).format(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Start Time', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () => _openTimePicker(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.violet300),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Text(
                  displayText.isEmpty ? 'Select time' : displayText,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const Spacer(),
                const Icon(Icons.access_time),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _openTimePicker(BuildContext context) {
    DateTime tempDateTime = selectedTime ?? DateTime.now();

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return SizedBox(
          height: 280,
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        onChanged(tempDateTime);
                        Navigator.pop(context);
                      },
                      child: const Text('Done'),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  use24hFormat: false, // ⬅️ AM / PM
                  initialDateTime: tempDateTime,
                  onDateTimeChanged: (value) {
                    tempDateTime = value;
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
