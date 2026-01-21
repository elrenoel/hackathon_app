import 'package:flutter/material.dart';
import 'package:hackathon_app/color/app_colors.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        spacing: 15,
        children: [
          SizedBox(height: 32),
          Row(
            children: [
              BackButton(color: AppColors.black5),
              Text(
                'Create New Account',
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium?.copyWith(color: AppColors.black5),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, left: 16, top: 10),
              child: Column(
                children: [
                  Column(
                    spacing: 30,
                    children: [
                      SizedBox(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Text(
                          'Create a free account to begin your focus journey and personalize how Neura supports the way you learn',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: AppColors.black5),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpPage(),
                              ),
                            );
                          },
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.violet400,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 18),
                          ),
                          child: Text(
                            'Continue with email',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                      Center(child: Text('or')),
                      Column(
                        spacing: 10,
                        children: [
                          anotherSingUpButtton(
                            Icon(
                              Icons.apple,
                              size: 30,
                              color: AppColors.black4,
                            ),
                            'Continue with Apple',
                            context,
                          ),
                          anotherSingUpButtton(
                            Image.network(
                              'https://img.icons8.com/?size=100&id=17949&format=png&color=000000',
                              height: 30,
                            ),
                            'Continue with Google',
                            context,
                          ),
                          anotherSingUpButtton(
                            Icon(
                              Icons.facebook,
                              size: 30,
                              color: Colors.indigo,
                            ),
                            'Continue with Facebook',
                            context,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  SafeArea(
                    child: Text(
                      'By using Neura, you agree to the \n Terms and Privacy Policy.',
                      style: Theme.of(context).textTheme.labelSmall,
                      textAlign: TextAlign.center,
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

Widget anotherSingUpButtton(Widget icon, String content, BuildContext context) {
  return SizedBox(
    width: double.infinity,
    child: OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.symmetric(vertical: 18),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 5,
        children: [
          icon,
          Text(
            content,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.black5),
          ),
        ],
      ),
    ),
  );
}
