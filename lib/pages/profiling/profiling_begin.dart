import 'package:flutter/material.dart';
import 'package:hackathon_app/color/app_colors.dart';
import 'package:hackathon_app/pages/profiling/profiling_questions.dart';

class ProfilingBegin extends StatelessWidget {
  const ProfilingBegin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        spacing: 50,
        children: [
          Stack(
            children: [
              ClipPath(
                clipper: BottomCurveClipper(),
                child: Container(
                  height: 450,
                  width: double.infinity,
                  color: AppColors.violet100,
                ),
              ),
              Positioned(
                top: 60,
                left: 0,
                right: 0,
                child: Image.asset(
                  'assets/images/profiling.png',
                  height: 330,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                spacing: 15,
                children: [
                  Center(
                    child: Text(
                      'Begin Your Focus Journey',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  Text(
                    'Neura is a space to explore and strengthen your attention through guided thinking and deep reading. Before you start, you’ll take 5 quick questions to map how your mind works, so every session feels more personal and effective.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      height: 1.8,
                      color: AppColors.black5,
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfilingQuestions(),
                            ),
                          );
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.violet300,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 18),
                        ),
                        child: Text(
                          'I’m Ready to Take the Test!',
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
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
