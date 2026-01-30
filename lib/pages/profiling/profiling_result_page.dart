import 'package:flutter/material.dart';
import 'package:hackathon_app/color/app_colors.dart';
import 'package:hackathon_app/main_app.dart';

class PersonaConfig {
  final String title;
  final String description;
  final String imageAsset;

  const PersonaConfig({
    required this.title,
    required this.description,
    required this.imageAsset,
  });
}

const personaMap = {
  'laser_focus': PersonaConfig(
    title: 'Laser Focus Squad',
    description:
        'You’re able to stay with one thought for a long time and move through complex ideas without losing momentum. Neura will help you protect this strength and gradually push your focus endurance even further.',
    imageAsset: 'assets/images/laser_focus.png',
  ),

  'ping_pong': PersonaConfig(
    title: 'Ping-Pong Thinkers',
    description:
        'Your mind moves fast and connects ideas easily, even if it sometimes jumps between them. Neura is designed to help you slow those jumps just enough, so you can keep your flexibility without losing important details.',
    imageAsset: 'assets/images/ping_pong.png',
  ),

  'butterfly': PersonaConfig(
    title: 'Butterfly Browsers',
    description:
        'Your attention is curious and responsive, always drawn to what feels new or stimulating. Neura will guide you through short, grounded focus sessions that help your mind stay present a little longer each time.',
    imageAsset: 'assets/images/butterfly.png',
  ),
};

class ProfilingResultPage extends StatelessWidget {
  final String persona;

  const ProfilingResultPage({super.key, required this.persona});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final config = personaMap[persona];

    if (config == null) {
      return const Scaffold(body: Center(child: Text('Unknown persona')));
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            children: [
              ClipPath(
                clipper: BottomCurveClipper(),
                child: Container(
                  height: size.height * 0.45, // ❗ responsive
                  width: double.infinity,
                  color: AppColors.violet100,
                ),
              ),
              Positioned(
                top: 60,
                left: 0,
                right: 0,
                child: Image.asset(
                  config.imageAsset,
                  height: size.height * 0.32, // ❗ responsive
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 24),

                  Column(
                    children: [
                      Text(
                        config.title,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        config.description,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          height: 1.8,
                          color: AppColors.black5,
                        ),
                      ),
                    ],
                  ),

                  const Spacer(), // 🔑 dorong button ke bawah

                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const MainApp()),
                        );
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.violet300,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'I got it!',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 70);

    path.quadraticBezierTo(
      size.width / 2,
      size.height + 30,
      size.width,
      size.height - 70,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
