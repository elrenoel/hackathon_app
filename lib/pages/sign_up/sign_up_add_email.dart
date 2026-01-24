import 'package:flutter/material.dart';
import 'package:hackathon_app/color/app_colors.dart';
// import 'package:hackathon_app/pages/sign_up/sign_up_verification_email.dart';
// import 'package:hackathon_app/widgets/sign_up_widget/step_indicator.dart';
import 'package:hackathon_app/services/auth_service.dart';
import 'package:hackathon_app/pages/home_page.dart';
import 'package:hackathon_app/widgets/step_indicator.dart';

class SignUpAddEmail extends StatefulWidget {
  const SignUpAddEmail({super.key});

  @override
  State<SignUpAddEmail> createState() => _SignUpAddEmailState();
}

class _SignUpAddEmailState extends State<SignUpAddEmail> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        spacing: 17,
        children: [
          SizedBox(height: 30),
          Row(
            children: [
              BackButton(color: AppColors.black5),
              Text(
                'Add your email',
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium?.copyWith(color: AppColors.black5),
              ),
            ],
          ),

          stepIndicator(1, 3),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                right: 16,
                left: 16,
                bottom: 32,
                top: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 10,
                children: [
                  Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Full Name'),
                      TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          hintText: 'Your name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),

                      Text('Email'),
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: 'example@mail.com',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),

                      Text('Password'),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Create password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 5),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: _loading
                          ? null
                          : () async {
                              final navigator = Navigator.of(context);
                              final messenger = ScaffoldMessenger.of(context);

                              setState(() => _loading = true);

                              final error = await AuthService.register(
                                _nameController.text.trim(),
                                _emailController.text.trim(),
                                _passwordController.text.trim(),
                              );

                              if (!mounted) return;

                              setState(() => _loading = false);

                              if (error == null) {
                                navigator.pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (_) => const HomePage(),
                                  ),
                                  (route) => false,
                                );
                              } else {
                                messenger.showSnackBar(
                                  SnackBar(content: Text(error)),
                                );
                              }
                            },

                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.violet400,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 18),
                      ),
                      child: Text(
                        'Create an account',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    'By using Neura, you agree to the \n Terms and Privacy Policy.',
                    style: Theme.of(context).textTheme.labelSmall,
                    textAlign: TextAlign.center,
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
