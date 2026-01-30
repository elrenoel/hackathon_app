import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_app/color/app_colors.dart';
import 'package:hackathon_app/pages/sign_up/sign_up_add_email.dart';
import 'package:hackathon_app/pages/sign_up/sign_up_create_password.dart';
import 'package:hackathon_app/services/auth_service.dart';
import 'package:hackathon_app/widgets/step_indicator.dart';

class SignUpVerificationEmail extends StatefulWidget {
  final String email;

  const SignUpVerificationEmail({super.key, required this.email});

  @override
  State<SignUpVerificationEmail> createState() =>
      _SignUpVerificationEmailState();
}

class _SignUpVerificationEmailState extends State<SignUpVerificationEmail> {
  final int codeLength = 6;
  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(codeLength, (_) => TextEditingController());
    focusNodes = List.generate(codeLength, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final c in controllers) {
      c.dispose();
    }
    for (final f in focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  String get otp => controllers.map((c) => c.text).join();

  Future<void> verifyOtp() async {
    if (otp.length != 6) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('OTP harus 6 digit')));
      return;
    }

    setState(() => _loading = true);

    final error = await AuthService.verifyOtp(email: widget.email, otp: otp);

    if (!mounted) return;

    setState(() => _loading = false);

    if (error == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => SignUpCreatePassword(email: widget.email),
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
      body: Column(
        children: [
          const SizedBox(height: 30),
          Row(
            children: [
              BackButton(color: AppColors.black5),
              Text(
                'Verify your email',
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium?.copyWith(color: AppColors.black5),
              ),
            ],
          ),

          stepIndicator(2, 3),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'We just sent 6-digit code to\n${widget.email}',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: List.generate(codeLength, (index) {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: TextField(
                            controller: controllers[index],
                            focusNode: focusNodes[index],
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            maxLength: 1,
                            decoration: InputDecoration(
                              counterText: '',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onChanged: (value) {
                              if (value.isNotEmpty && index < codeLength - 1) {
                                focusNodes[index + 1].requestFocus();
                              } else if (value.isEmpty && index > 0) {
                                focusNodes[index - 1].requestFocus();
                              }
                            },
                          ),
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: _loading ? null : verifyOtp,
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.violet400,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _loading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                              'Verify email',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: Colors.white),
                            ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodySmall,
                      children: [
                        const TextSpan(text: 'Wrong email?'),
                        TextSpan(
                          text: ' Send to different email',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: AppColors.violet400),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const SignUpAddEmail(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

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
