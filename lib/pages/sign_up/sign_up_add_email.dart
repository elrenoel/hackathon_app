import 'package:flutter/material.dart';
import 'package:hackathon_app/color/app_colors.dart';
import 'package:hackathon_app/pages/sign_up/sign_up_verification_email.dart';
import 'package:hackathon_app/services/auth_service.dart';
import 'package:hackathon_app/widgets/step_indicator.dart';

class SignUpAddEmail extends StatefulWidget {
  const SignUpAddEmail({super.key});

  @override
  State<SignUpAddEmail> createState() => _SignUpAddEmailState();
}

class _SignUpAddEmailState extends State<SignUpAddEmail> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  bool _loading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> register() async {
    if (_nameController.text.isEmpty || _emailController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Name & email wajib diisi')));
      return;
    }

    setState(() => _loading = true);

    final error = await AuthService.sendOtp(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
    );

    if (!mounted) return;

    setState(() => _loading = false);

    if (error == null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
              SignUpVerificationEmail(email: _emailController.text.trim()),
        ),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
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

            const SizedBox(height: 10),
            stepIndicator(1, 3),
            const SizedBox(height: 20),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Full Name'),
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: 'Your name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    const Text('Email'),
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'example@mail.com',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: _loading ? null : register,
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.violet400,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: _loading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                'Continue',
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(color: Colors.white),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: Text(
                'By using Neura, you agree to the \n Terms and Privacy Policy.',
                style: Theme.of(context).textTheme.labelSmall,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
