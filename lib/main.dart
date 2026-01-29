import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:hackathon_app/pages/focus_session.dart';
// import 'package:hackathon_app/main_app.dart';
import 'package:hackathon_app/pages/welcome_page.dart';
// import 'package:hackathon_app/pages/welcome_page.dart';
// import 'package:hackathon_app/pages/profiling/profiling_begin.dart';
// import 'package:hackathon_app/pages/welcome_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Neura',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          headlineLarge: GoogleFonts.poppins(
            textStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          headlineMedium: GoogleFonts.poppins(
            textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          headlineSmall: GoogleFonts.poppins(
            textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          bodyMedium: GoogleFonts.roboto(
            textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          bodySmall: GoogleFonts.roboto(
            textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          labelMedium: GoogleFonts.roboto(
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          labelSmall: GoogleFonts.roboto(
            textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
        ),
      ),
      home: const WelcomePage(),
    );
  }
}
