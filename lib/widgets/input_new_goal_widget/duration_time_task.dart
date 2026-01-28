import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_app/color/app_colors.dart';

class DurationTimeTask extends StatefulWidget {
  final ValueChanged<Duration>? onChanged;

  const DurationTimeTask({super.key, this.onChanged});

  @override
  State<DurationTimeTask> createState() => _DurationTimeTaskState();
}

class _DurationTimeTaskState extends State<DurationTimeTask> {
  int hours = 0;
  int minutes = 0;
  int seconds = 0;

  void _openPicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _DurationPicker(
        initialHours: hours,
        initialMinutes: minutes,
        initialSeconds: seconds,
        onConfirm: (h, m, s) {
          setState(() {
            hours = h;
            minutes = m;
            seconds = s;
          });
          widget.onChanged?.call(
            Duration(hours: hours, minutes: minutes, seconds: seconds),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Duration', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: _openPicker,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.violet300),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Text(
                  '${hours.toString().padLeft(2, '0')} : '
                  '${minutes.toString().padLeft(2, '0')} : '
                  '${seconds.toString().padLeft(2, '0')}',
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
}

class _DurationPicker extends StatefulWidget {
  final int initialHours;
  final int initialMinutes;
  final int initialSeconds;
  final Function(int, int, int) onConfirm;

  const _DurationPicker({
    required this.initialHours,
    required this.initialMinutes,
    required this.initialSeconds,
    required this.onConfirm,
  });

  @override
  State<_DurationPicker> createState() => _DurationPickerState();
}

class _DurationPickerState extends State<_DurationPicker> {
  late int h;
  late int m;
  late int s;

  @override
  void initState() {
    super.initState();
    h = widget.initialHours;
    m = widget.initialMinutes;
    s = widget.initialSeconds;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    widget.onConfirm(h, m, s);
                    Navigator.pop(context);
                  },
                  child: const Text('Done'),
                ),
              ],
            ),
          ),

          Expanded(
            child: Row(
              children: [
                _buildPicker(max: 24, initial: h, onChanged: (v) => h = v),
                const Text(':'),
                _buildPicker(max: 60, initial: m, onChanged: (v) => m = v),
                const Text(':'),
                _buildPicker(max: 60, initial: s, onChanged: (v) => s = v),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPicker({
    required int max,
    required int initial,
    required ValueChanged<int> onChanged,
  }) {
    return Expanded(
      child: CupertinoPicker(
        scrollController: FixedExtentScrollController(initialItem: initial),
        itemExtent: 36,
        onSelectedItemChanged: onChanged,
        children: List.generate(
          max,
          (index) => Center(child: Text(index.toString().padLeft(2, '0'))),
        ),
      ),
    );
  }
}
