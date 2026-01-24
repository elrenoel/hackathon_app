import 'package:flutter/material.dart';
import 'package:hackathon_app/color/app_colors.dart';

class ReminderTask extends StatefulWidget {
  final ValueChanged<String>? onChangedReminder;

  const ReminderTask({super.key, this.onChangedReminder});

  @override
  State<ReminderTask> createState() => _ReminderTaskState();
}

class _ReminderTaskState extends State<ReminderTask> {
  String? valueReminder = 'noReminder';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Reminder', style: Theme.of(context).textTheme.headlineMedium),
        SizedBox(height: 10),

        DropdownButtonFormField<String>(
          initialValue: valueReminder,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.violet300),
            ),
          ),
          items: [
            DropdownMenuItem(
              value: 'noReminder',
              child: Text('Choose reminder'),
            ),
            DropdownMenuItem(value: '5min', child: Text('5 minutes berfore')),
            DropdownMenuItem(value: '10min', child: Text('10 minutes berfore')),
            DropdownMenuItem(value: '15min', child: Text('15 minutes berfore')),
          ],
          onChanged: (value) {
            setState(() {
              valueReminder = value;
            });
            widget.onChangedReminder?.call(value!);
          },
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
    );
  }
}
