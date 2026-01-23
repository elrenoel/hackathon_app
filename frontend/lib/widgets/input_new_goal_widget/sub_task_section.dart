import 'package:flutter/material.dart';
import 'package:hackathon_app/pages/input_goal_page.dart';

class SubTaskSection extends StatefulWidget {
  final ValueChanged<List<SubTask>> onChanged;
  const SubTaskSection({super.key, required this.onChanged});

  @override
  State<SubTaskSection> createState() => _SubTaskSectionState();
}

class _SubTaskSectionState extends State<SubTaskSection> {
  final List<SubTask> subTaskList = [];
  final TextEditingController subTaskController = TextEditingController();
  bool isAdding = false;

  @override
  void dispose() {
    subTaskController.dispose();
    super.dispose();
  }

  void _notifyParent() {
    widget.onChanged(List.from(subTaskList));
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(child: Text('Subtask')),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  setState(() => isAdding = true);
                },
              ),
            ],
          ),

          if (isAdding)
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: subTaskController,
                      decoration: const InputDecoration(
                        hintText: 'Subtask title',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.check),
                    onPressed: () {
                      if (subTaskController.text.isEmpty) return;

                      setState(() {
                        subTaskList.add(SubTask(title: subTaskController.text));
                        subTaskController.clear();
                        isAdding = false;
                      });

                      _notifyParent();
                    },
                  ),
                ],
              ),
            ),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: subTaskList.map((subTask) {
                  return Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(1, 1),
                          blurRadius: 3,
                          // ignore: deprecated_member_use
                          color: Colors.black.withOpacity(0.15),
                        ),
                      ],
                    ),
                    child: Text(
                      subTask.title,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
