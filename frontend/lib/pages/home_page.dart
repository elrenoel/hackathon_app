import 'package:flutter/material.dart';
import 'package:hackathon_app/pages/focus_timer.dart';
import 'package:hackathon_app/pages/input_goal_page.dart';
import 'package:hackathon_app/providers/todo_provider.dart';
import 'package:hackathon_app/widgets/emotion_btn.dart';
import 'package:provider/provider.dart';

class Todo {
  final String title;
  final int durationHours; // menit
  final int durationMinutes; // menit
  final bool isDone;

  Todo({
    required this.title,
    required this.durationHours,
    required this.durationMinutes,
    this.isDone = false,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedEmotion;
  final List<Todo> todos = [];

  final TextEditingController titleController = TextEditingController();
  final TextEditingController durationHoursController = TextEditingController();
  final TextEditingController durationMinutesController =
      TextEditingController();

  bool isAdding = false; // kontrol tampil/tidaknya input

  void toggleEmotion(String emotion) {
    setState(() {
      if (selectedEmotion == emotion) {
        selectedEmotion = null; // tekan 2x → mati
      } else {
        selectedEmotion = emotion; // pilih baru
      }
    });
  }

  void addTodo() {
    setState(() {
      isAdding = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final todoProvider = context.watch<TodoProvider>();
    final todos = todoProvider.todos;

    return Padding(
      padding: const EdgeInsets.only(top: 50, right: 20, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(999),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(1, 1),
                      blurRadius: 3,
                      // ignore: deprecated_member_use
                      color: Colors.black.withOpacity(0.15),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: Image.asset('assets/icons/bro.jpg', fit: BoxFit.cover),
                ),
              ),
              SizedBox(width: 10),
              Text("Hi User!", style: Theme.of(context).textTheme.labelLarge),
            ],
          ),
          SizedBox(height: 50),
          Center(
            child: Column(
              children: [
                Text(
                  "☀️ Good Morning",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      // Daily Check in Emotion/Mood
                      Column(
                        children: [
                          Text(
                            "How have things been today?",
                            style: Theme.of(context).textTheme.headlineLarge,
                            textAlign: TextAlign.center,
                          ),

                          SizedBox(height: 10),

                          // Emotion Buttons
                          Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 12,
                            runSpacing: 12,
                            children: [
                              emotionButton(
                                text: 'Happy',
                                color: Colors.lightGreenAccent,
                                isSelected: selectedEmotion == 'Happy',
                                onPressed: () => toggleEmotion('Happy'),
                              ),
                              emotionButton(
                                text: 'Angry',
                                color: Colors.redAccent,
                                isSelected: selectedEmotion == 'Angry',
                                onPressed: () => toggleEmotion('Angry'),
                              ),
                              emotionButton(
                                text: 'Excited',
                                color: Colors.purpleAccent,
                                isSelected: selectedEmotion == 'Excited',
                                onPressed: () => toggleEmotion('Excited'),
                              ),
                              emotionButton(
                                text: 'Stressed',
                                color: Colors.orangeAccent,
                                isSelected: selectedEmotion == 'Stressed',
                                onPressed: () => toggleEmotion('Stressed'),
                              ),
                              emotionButton(
                                text: 'Sad',
                                color: Colors.blueAccent,
                                isSelected: selectedEmotion == 'Sad',
                                onPressed: () => toggleEmotion('Sad'),
                              ),
                            ],
                          ),

                          // End Emotion Buttons
                          SizedBox(height: 10),

                          // Submit Button
                          TextButton(
                            onPressed: () {
                              debugPrint('Button ditekan');
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 100),
                            ),
                            child: Text(
                              'Submit',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: Colors.white),
                            ),
                          ),

                          // End Submit Button
                        ],
                      ),

                      //End Daily Check in Emotion/Mood
                      SizedBox(height: 15),

                      // List Todo Today
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'What do you want to get done today?',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge,
                                  ),
                                  Text(
                                    'for good focus max 3–5 item todo list today',
                                  ),
                                ],
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => InputGoalPage(),
                                    ),
                                  );
                                },
                                icon: Image.asset('assets/icons/add.png'),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),

                          // Input Todo
                          if (isAdding)
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(12),
                              margin: const EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    offset: const Offset(1, 1),
                                    blurRadius: 6,
                                    // ignore: deprecated_member_use
                                    color: Colors.black.withOpacity(0.15),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: TextField(
                                          controller: titleController,
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodyLarge,
                                          decoration: InputDecoration(
                                            hintText: 'Todo name',
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        flex: 1,
                                        child: TextField(
                                          controller: durationHoursController,
                                          keyboardType: TextInputType.number,
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodyMedium,
                                          decoration: InputDecoration(
                                            hintText: 'Hrs',
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        flex: 1,
                                        child: TextField(
                                          controller: durationMinutesController,
                                          keyboardType: TextInputType.number,
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodyMedium,
                                          decoration: InputDecoration(
                                            hintText: 'Min',
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: FilledButton(
                                      style: FilledButton.styleFrom(
                                        backgroundColor: Colors.black,
                                      ),
                                      onPressed: () {
                                        if (titleController.text.isEmpty) {
                                          return;
                                        }
                                        final int hours =
                                            int.tryParse(
                                              durationHoursController.text,
                                            ) ??
                                            0;
                                        final int minutes =
                                            int.tryParse(
                                              durationMinutesController.text,
                                            ) ??
                                            0;
                                        if (hours == 0 && minutes == 0) {
                                          return;
                                        }

                                        context.read<TodoProvider>().addTodo(
                                          Todo(
                                            title: titleController.text,
                                            durationHours: hours,
                                            durationMinutes: minutes,
                                          ),
                                        );

                                        setState(() {
                                          titleController.clear();
                                          durationHoursController.clear();
                                          durationMinutesController.clear();
                                          isAdding = false;
                                        });
                                      },
                                      child: Text(
                                        'Add',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          // End Input Todo
                          SizedBox(height: 10),

                          // List Todos
                          Column(
                            children: todos.asMap().entries.map((entry) {
                              final todo = entry.value;

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(14),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: const Offset(1, 1),
                                        blurRadius: 6,
                                        // ignore: deprecated_member_use
                                        color: Colors.black.withOpacity(0.15),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              todo.title,
                                              style: Theme.of(
                                                context,
                                              ).textTheme.bodyLarge,
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Image.asset(
                                                  'assets/icons/clock.png',
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  '${todo.durationHours} hr',
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  '${todo.durationMinutes} min',
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),

                                      Row(
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) => FocusTimer(
                                                    hours: todo.durationHours,
                                                    minutes:
                                                        todo.durationMinutes,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Focus Now',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                        color: const Color(
                                                          0xFF0B1FD8,
                                                        ),
                                                      ),
                                                ),
                                                const SizedBox(width: 10),
                                                Image.asset(
                                                  'assets/icons/arrow.png',
                                                ),
                                              ],
                                            ),
                                          ),
                                          IconButton(
                                            icon: const Icon(
                                              Icons.delete_outline,
                                            ),
                                            onPressed: () {
                                              context
                                                  .read<TodoProvider>()
                                                  .deleteTodo(entry.key);
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),

                          // End List Todos
                        ],
                      ),

                      // End List Todo today
                      SizedBox(height: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'For you',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          SizedBox(height: 10),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(1, 1),
                                  blurRadius: 6,
                                  // ignore: deprecated_member_use
                                  color: Colors.black.withOpacity(0.15),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Short sessions Deep Read (7–10 minutes) & Based on your mood & schedule',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.displayMedium,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Image.asset(
                                    'assets/icons/arrow.png',
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
