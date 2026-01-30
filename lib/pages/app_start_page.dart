import 'package:flutter/material.dart';
import 'package:hackathon_app/main_app.dart';
import 'package:hackathon_app/pages/profiling/profiling_questions.dart';
import 'package:hackathon_app/pages/sign_in/sign_in_page.dart';
import 'package:hackathon_app/services/auth_service.dart';

class AppStartPage extends StatefulWidget {
  const AppStartPage({super.key});

  @override
  State<AppStartPage> createState() => _AppStartPageState();
}

class _AppStartPageState extends State<AppStartPage> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    final user = await AuthService.getCurrentUser();

    if (!mounted) return;

    if (user == null) {
      _go(const SignInPage());
      return;
    }

    if (user['profiling_completed'] == false) {
      _go(const ProfilingQuestions());
      return;
    }

    _go(const MainApp());
  }

  void _go(Widget page) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
