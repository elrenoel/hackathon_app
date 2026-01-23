import 'package:flutter/material.dart';

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
        const Text(
          'Durasi Waktu',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            // Hours
            Expanded(
              child: DropdownButtonFormField<int>(
                initialValue: valueHours,
                decoration: const InputDecoration(
                  labelText: 'Hours',
                  border: OutlineInputBorder(),
                ),
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
                decoration: const InputDecoration(
                  labelText: 'Minutes',
                  border: OutlineInputBorder(),
                ),
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
