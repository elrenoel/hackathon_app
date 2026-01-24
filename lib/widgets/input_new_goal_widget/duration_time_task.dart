import 'package:flutter/material.dart';
import 'package:hackathon_app/color/app_colors.dart';

class DurationTimeTask extends StatefulWidget {
  final ValueChanged<int>? onChangedHours;
  final ValueChanged<int>? onChangedMinutes;

  const DurationTimeTask({
    super.key,
    this.onChangedHours,
    this.onChangedMinutes,
  });

  @override
  State<DurationTimeTask> createState() => _DurationTimeTaskState();
}

class _DurationTimeTaskState extends State<DurationTimeTask> {
  int valueHours = 0;
  int valueMinutes = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Duration Time',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            // Hours
            Expanded(
              child: DropdownButtonFormField<int>(
                initialValue: valueHours,
                menuMaxHeight: 240,
                decoration: InputDecoration(
                  labelText: 'Hours',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.violet300),
                  ),
                ),
                style: Theme.of(context).textTheme.labelSmall,
                items: List.generate(25, (index) {
                  return DropdownMenuItem<int>(
                    value: index,
                    child: Text('$index'),
                  );
                }),
                onChanged: (value) {
                  if (value == null) return;

                  setState(() {
                    valueHours = value;
                  });

                  widget.onChangedHours?.call(value);
                },
              ),
            ),
            const SizedBox(width: 12),

            // Minutes
            Expanded(
              child: DropdownButtonFormField<int>(
                initialValue: valueMinutes,
                menuMaxHeight: 240,
                decoration: InputDecoration(
                  labelText: 'Minutes',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.violet300),
                  ),
                ),
                style: Theme.of(context).textTheme.labelSmall,
                items: List.generate(61, (index) {
                  return DropdownMenuItem(value: index, child: Text('$index'));
                }),
                onChanged: (value) {
                  setState(() {
                    valueMinutes = value ?? 0;
                  });
                  widget.onChangedMinutes?.call(value!);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
