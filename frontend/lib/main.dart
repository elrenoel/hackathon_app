import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon_app/pages/read_task_page.dart';
import 'package:hackathon_app/providers/todo_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => TodoProvider(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        textTheme: GoogleFonts.instrumentSansTextTheme(
          const TextTheme(
            headlineLarge: TextStyle(fontWeight: FontWeight.w700, fontSize: 32),
            headlineMedium: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 24,
            ),
            headlineSmall: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            labelLarge: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ), // semibold // bold
            labelMedium: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            labelSmall: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            bodyLarge: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            bodyMedium: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
        ),
      ),
      home: const ReadTaskPage(),
    );
  }
}
