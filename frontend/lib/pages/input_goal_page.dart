import 'package:flutter/material.dart';

class InputGoalPage extends StatefulWidget {
  const InputGoalPage({super.key});

  @override
  State<InputGoalPage> createState() => _InputGoalPageState();
}

class _InputGoalPageState extends State<InputGoalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        // ignore: deprecated_member_use
                        color: Colors.black.withOpacity(0.15),
                        offset: const Offset(0, 2), // y = 2
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Image.asset('assets/icons/backbtn.png'),
                  ),
                ),
                SizedBox(width: 10),
                Text('New Goal'),
              ],
            ),

            SizedBox(height: 10),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Task Title'),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'enter task title',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Task Title'),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'enter task title',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Duration'),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'enter task title',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Reminder'),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'enter task title',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
