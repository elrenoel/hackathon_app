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
    return Column(
      mainAxisSize: MainAxisSize.min, // ⬅️ WAJIB
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ===== HEADER =====
        Row(
          children: [
            Expanded(
              child: Text(
                'Subtask',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                setState(() => isAdding = true);
              },
            ),
          ],
        ),

        // ===== INPUT ADD SUBTASK =====
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
                    style: Theme.of(context).textTheme.labelSmall,
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

        // ===== LIST SUBTASK =====
        ListView.builder(
          shrinkWrap: true, // ⬅️ KRUSIAL
          physics: const NeverScrollableScrollPhysics(),
          itemCount: subTaskList.length,
          itemBuilder: (context, index) {
            final subTask = subTaskList[index];

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
                    color: Colors.black.withOpacity(0.15),
                  ),
                ],
              ),
              child: Text(
                subTask.title,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            );
          },
        ),
      ],
    );
  }
}
