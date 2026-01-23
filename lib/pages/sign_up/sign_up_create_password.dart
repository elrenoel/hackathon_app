import 'package:flutter/material.dart';
import 'package:hackathon_app/color/app_colors.dart';
import 'package:hackathon_app/pages/sign_up/sign_up_done.dart';
import 'package:hackathon_app/widgets/sign_up_widget/requirement_item.dart';
import 'package:hackathon_app/widgets/step_indicator.dart';

class SignUpCreatePassword extends StatefulWidget {
  const SignUpCreatePassword({super.key});

  @override
  State<SignUpCreatePassword> createState() => _SignUpCreatePasswordState();
}

class _SignUpCreatePasswordState extends State<SignUpCreatePassword> {
  final TextEditingController _controller = TextEditingController();
  bool _obscure = true;

  bool get hasTyping => _controller.text.isNotEmpty;
  bool get hasMinLength => _controller.text.length >= 8;
  bool get hasNumber => RegExp(r'\d').hasMatch(_controller.text);
  bool get hasSymbol =>
      RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(_controller.text);

  int get strength {
    int value = 0;
    if (hasTyping) value++;
    if (hasMinLength) value++;
    if (hasNumber) value += 2;
    if (hasSymbol) value += 2;
    return value;
  }

  Color get strengthColor {
    switch (strength) {
      case 1:
        return AppColors.black4;
      case 2:
        return AppColors.redPrimary;
      case 3:
        return AppColors.yellow;
      case 4:
        return AppColors.yellow;
      case 5:
        return AppColors.yellow;
      case 6:
        return AppColors.green;
      default:
        return AppColors.gray500;
    }
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
                'Create your password',
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium?.copyWith(color: AppColors.black5),
              ),
            ],
          ),

          stepIndicator(3, 3),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                right: 16,
                left: 16,
                top: 10,
                bottom: 32,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Password',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),

                  /// Password field
                  TextField(
                    controller: _controller,
                    obscureText: _obscure,
                    onChanged: (_) => setState(() {}),
                    style: Theme.of(context).textTheme.bodySmall,
                    decoration: InputDecoration(
                      hintText: 'Enter password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscure ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () => setState(() => _obscure = !_obscure),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// Strength bar
                  LinearProgressIndicator(
                    value: strength / 6,
                    minHeight: 6,
                    backgroundColor: Colors.grey.shade300,
                    valueColor: AlwaysStoppedAnimation(strengthColor),
                    borderRadius: BorderRadius.circular(999),
                  ),

                  const SizedBox(height: 16),

                  RequirementItem('8 characters minimum', hasMinLength),
                  RequirementItem('a number', hasNumber),
                  RequirementItem('a symbol', hasSymbol),

                  const SizedBox(height: 8),

                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        if (strength == 6) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpDone(),
                            ),
                          );
                        }
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: strength == 6
                            ? AppColors.violet400
                            : AppColors.violet200,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 18),
                      ),
                      child: Text(
                        'Continue',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  Spacer(),
                  Center(
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
