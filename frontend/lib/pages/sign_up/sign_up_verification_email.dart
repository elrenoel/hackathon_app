import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_app/color/app_colors.dart';
import 'package:hackathon_app/pages/sign_up/sign_up_add_email.dart';
import 'package:hackathon_app/pages/sign_up/sign_up_create_password.dart';
import 'package:hackathon_app/widgets/sign_up_widget/step_indicator.dart';

class SignUpVerificationEmail extends StatefulWidget {
  const SignUpVerificationEmail({super.key});

  @override
  State<SignUpVerificationEmail> createState() =>
      _SignUpVerificationEmailState();
}

class _SignUpVerificationEmailState extends State<SignUpVerificationEmail> {
  final int codeLength = 6;
  List<TextEditingController>? controllers;
  List<FocusNode>? focusNodes;
  String email = 'elreno@mail.com';

  @override
  void initState() {
    super.initState();
    controllers = List.generate(codeLength, (_) => TextEditingController());
    focusNodes = List.generate(codeLength, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final c in controllers!) {
      c.dispose();
    }
    for (final f in focusNodes!) {
      f.dispose();
    }
    super.dispose();
  }

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
                'Verify your email',
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium?.copyWith(color: AppColors.black5),
              ),
            ],
          ),

          stepIndicator(2),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                right: 16,
                left: 16,
                top: 10,
                bottom: 32,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 10,
                children: [
                  Text(
                    'We just sent 5-digit code to\n $email, enter it bellow:',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  SizedBox(height: 10),
                  Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Code',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        spacing: 5,
                        children: List.generate(codeLength, (index) {
                          return Expanded(
                            child: SizedBox(
                              child: TextField(
                                controller: controllers?[index],
                                focusNode: focusNodes?[index],
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                maxLength: 1,
                                style: Theme.of(context).textTheme.bodySmall,
                                decoration: InputDecoration(
                                  counterText: '',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      color: Colors.purple,
                                      width: 2,
                                    ),
                                  ),
                                ),
                                onChanged: (value) {
                                  if (value.isNotEmpty &&
                                      index < codeLength - 1) {
                                    focusNodes?[index + 1].requestFocus();
                                  }
                                  if (value.isEmpty && index > 0) {
                                    focusNodes?[index - 1].requestFocus();
                                  }
                                },
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpCreatePassword(),
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
                        'Verify email',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.black, fontSize: 14),
                      children: [
                        TextSpan(
                          text: 'Wrong email?',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: AppColors.black5),
                        ),
                        TextSpan(
                          text: ' Send to different email',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: AppColors.black5),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUpAddEmail(),
                                ),
                              );
                            },
                        ),
                      ],
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
