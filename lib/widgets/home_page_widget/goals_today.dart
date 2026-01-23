import 'package:flutter/material.dart';
import 'package:hackathon_app/pages/input_goal_page.dart';

class GoalsToday extends StatefulWidget {
  const GoalsToday({super.key});

  @override
  State<GoalsToday> createState() => _GoalsTodayState();
}

class _GoalsTodayState extends State<GoalsToday> {
  final List<Task> goals = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'What do you want to get done today?',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text('for good focus max 3–5 item todo list today'),
              ],
            ),
            IconButton(
              onPressed: () async {
                final result = await Navigator.push<Task>(
                  context,
                  MaterialPageRoute(builder: (context) => InputGoalPage()),
                );

                if (result != null) {
                  setState(() {
                    goals.add(result);
                  });
                }
              },
              icon: Image.asset('assets/icons/add.png'),
            ),
          ],
        ),

        // List Todos
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: goals.length,
          itemBuilder: (context, index) {
            final task = goals[index];

            return Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: Text(task.title)),
                    Expanded(child: Text(task.durationTime)),

                    !task.goalsDone
                        ? Row(
                            children: [
                              Text('Focus Now'),
                              IconButton(
                                onPressed: () {},
                                icon: Image.asset('assets/icons/arrow.png'),
                              ),
                            ],
                          )
                        : Text('Done'),
                  ],
                ),
              ),
            );
          },
        ),

        // End List Todos
      ],
    );
  }
}
