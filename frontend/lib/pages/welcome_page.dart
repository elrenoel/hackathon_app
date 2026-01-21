import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_app/color/app_colors.dart';
import 'package:hackathon_app/pages/sign_in_page.dart';
import 'package:hackathon_app/pages/sign_up/sign_up_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              spacing: 24,
              children: [
                Text(
                  'Welcome to Neura',
                  style: Theme.of(
                    context,
                  ).textTheme.headlineLarge?.copyWith(color: Colors.white),
                ),
                Text(
                  'Explore how your mind focuses through guided thinking, deep reading, and small moments of reflection designed to help you stay present longer, one session at a time',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      );
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 18),
                    ),
                    child: Text(
                      'Create an account',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: AppColors.black5),
                    ),
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 14),
                    children: [
                      TextSpan(
                        text: 'Already have an account? ',
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall?.copyWith(color: Colors.white),
                      ),
                      TextSpan(
                        text: 'Login',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignInPage(),
                              ),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
