import 'package:flutter/material.dart';
import 'package:hackathon_app/models/sub_task.dart';

class SubTaskSection extends StatefulWidget {
  final ValueChanged<List<SubTask>> onChanged;

  const SubTaskSection({super.key, required this.onChanged});

  @override
  State<SubTaskSection> createState() => _SubTaskSectionState();
}

class _SubTaskSectionState extends State<SubTaskSection> {
  final List<SubTask> _subTasks = [];
  final TextEditingController _controller = TextEditingController();
  bool isAdding = false;

  void _addSubTask() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _subTasks.add(SubTask(title: text));
      _controller.clear();
    });

    widget.onChanged(List<SubTask>.from(_subTasks));
  }

  void _removeSubTask(SubTask task) {
    setState(() {
      _subTasks.remove(task);
    });

    widget.onChanged(List<SubTask>.from(_subTasks));
  }

  void onAddPressed() {
    setState(() {
      isAdding = !isAdding;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Subtasks',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            IconButton(onPressed: onAddPressed, icon: const Icon(Icons.add)),
          ],
        ),
        if (isAdding)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Add subtask',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: _addSubTask,
                ),
              ),
            ),
          ),
        const SizedBox(height: 12),
        ..._subTasks.map((subTask) {
          return Row(
            children: [
              Expanded(child: Text(subTask.title)),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => _removeSubTask(subTask),
              ),
            ],
          );
        }),
      ],
    );
  }
}
