import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'main_app.dart';

class SplashLottiePage extends StatefulWidget {
  const SplashLottiePage({super.key});

  @override
  State<SplashLottiePage> createState() => _SplashLottiePageState();
}

class _SplashLottiePageState extends State<SplashLottiePage> {
  static const _splashDuration = Duration(seconds: 7);

  @override
  void initState() {
    super.initState();

    Future.delayed(_splashDuration, () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainApp()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Center(
        child: SizedBox(
          width: 200,
          height: 200,
          child: Lottie.asset('assets/lottie/splash.json', fit: BoxFit.cover),
        ),
      ),
    );
  }
}
