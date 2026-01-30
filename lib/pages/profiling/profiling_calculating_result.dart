import 'package:flutter/material.dart';
import 'package:hackathon_app/color/app_colors.dart';
import 'package:hackathon_app/pages/profiling/profiling_result_page.dart';

class ProfilingCalculatingResult extends StatelessWidget {
  final String persona;

  const ProfilingCalculatingResult({super.key, required this.persona});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            children: [
              ClipPath(
                clipper: BottomCurveClipper(),
                child: Container(
                  height: size.height * 0.5, // ❗ responsive
                  width: double.infinity,
                  color: AppColors.violet100,
                ),
              ),
              Positioned(
                top: 60,
                left: 0,
                right: 0,
                child: Image.asset(
                  'assets/images/9.png',
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
                        'Mapping Your Focus Patterns',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'We’re analyzing your responses to understand how your attention works and tailor your experience in Neura. This result is based on self-reflection, not a medical or psychological assessment, and should be used as a personal guide rather than a fixed diagnosis.',
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
                          MaterialPageRoute(
                            builder: (_) =>
                                ProfilingResultPage(persona: persona),
                          ),
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
                        'Calculating Your Result',
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
