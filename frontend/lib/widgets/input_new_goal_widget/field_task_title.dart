import 'package:flutter/material.dart';

class FieldTaskTitle extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const FieldTaskTitle({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Task Title'),
        SizedBox(height: 10),
        TextField(
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: 'Enter Task Title',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
