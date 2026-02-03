import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'main_app.dart';
import 'package:hackathon_app/pages/welcome_page.dart';
import 'package:hackathon_app/providers/auth_provider.dart';

// void main() {
//   runApp(MyApp());
// }
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()..checkAuth()),
      ],
      child: const MyApp(),
    ),
  );
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
      home: Consumer<AuthProvider>(
        builder: (_, auth, __) {
          debugPrint(
            "AUTH → initialized=${auth.isInitialized}, loggedIn=${auth.isLoggedIn}",
          );
          // ⏳ Masih cek token
          if (!auth.isInitialized) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          // ✅ Sudah login
          if (auth.isLoggedIn) {
            return const MainApp();
          }

          // ❌ Belum login
          return const WelcomePage();
        },
      ),
    );
  }
}
