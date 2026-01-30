import 'package:flutter/material.dart';
import 'package:hackathon_app/color/app_colors.dart';
import 'package:hackathon_app/pages/profiling/profiling_begin.dart';
import 'package:hackathon_app/services/auth_service.dart';
import 'package:hackathon_app/widgets/sign_up_widget/requirement_item.dart';
import 'package:hackathon_app/widgets/step_indicator.dart';

class SignUpCreatePassword extends StatefulWidget {
  final String email;

  const SignUpCreatePassword({super.key, required this.email});

  @override
  State<SignUpCreatePassword> createState() => _SignUpCreatePasswordState();
}

class _SignUpCreatePasswordState extends State<SignUpCreatePassword> {
  final TextEditingController _controller = TextEditingController();
  bool _obscure = true;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
    if (strength <= 1) return AppColors.black4;
    if (strength <= 2) return AppColors.redPrimary;
    if (strength <= 5) return AppColors.yellow;
    return AppColors.green;
  }

  Future<void> submit() async {
    if (strength != 6) return;

    setState(() => _loading = true);

    final error = await AuthService.setPassword(
      email: widget.email,
      password: _controller.text,
    );

    if (!mounted) return;

    setState(() => _loading = false);

    if (error == null) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const ProfilingBegin()),
        (_) => false,
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
                'Create your password',
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium?.copyWith(color: AppColors.black5),
              ),
            ],
          ),

          const SizedBox(height: 10),
          stepIndicator(3, 3),
          const SizedBox(height: 20),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Password',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),

                  const SizedBox(height: 8),

                  TextField(
                    controller: _controller,
                    obscureText: _obscure,
                    onChanged: (_) => setState(() {}),
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

                  LinearProgressIndicator(
                    value: strength / 6,
                    minHeight: 6,
                    valueColor: AlwaysStoppedAnimation<Color>(strengthColor),
                    backgroundColor: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(999),
                  ),

                  const SizedBox(height: 16),

                  RequirementItem('8 characters minimum', hasMinLength),
                  RequirementItem('a number', hasNumber),
                  RequirementItem('a symbol', hasSymbol),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: _loading ? null : submit,
                      style: FilledButton.styleFrom(
                        backgroundColor: strength == 6
                            ? AppColors.violet400
                            : AppColors.violet200,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _loading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('Continue'),
                    ),
                  ),

                  const Spacer(),

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
