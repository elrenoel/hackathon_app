import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'pages/welcome_page.dart';
import 'main_app.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (_, auth, __) {
        // 1️⃣ Masih cek token
        if (!auth.isInitialized) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // 2️⃣ Belum login
        if (!auth.isLoggedIn) {
          return const WelcomePage();
        }

        // 3️⃣ Sudah login
        return const MainApp();
      },
    );
  }
}
