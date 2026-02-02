import 'package:flutter/material.dart';
import 'package:hackathon_app/color/app_colors.dart';
// import 'package:hackathon_app/pages/app_start_page.dart';
// import 'package:hackathon_app/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:hackathon_app/providers/auth_provider.dart';
// import 'package:hackathon_app/pages/home_page.dart';

class SignInWithEmail extends StatefulWidget {
  const SignInWithEmail({super.key});

  @override
  State<SignInWithEmail> createState() => _SignInWithEmailState();
}

class _SignInWithEmailState extends State<SignInWithEmail> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  bool _obscure = true;
  // bool _loading = false;
  bool get hasTypingEmail => _controllerEmail.text.isNotEmpty;
  bool get hasTypingPassword => _controllerPassword.text.isNotEmpty;

  Future<void> _handleLogin() async {
    final auth = context.read<AuthProvider>();

    final success = await auth.login(
      _controllerEmail.text.trim(),
      _controllerPassword.text.trim(),
    );

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email atau password salah")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 32),
          Row(
            children: [
              BackButton(color: AppColors.black5),
              Text(
                'Log into account',
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium?.copyWith(color: AppColors.black5),
              ),
            ],
          ),
          SizedBox(height: 24),
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
                spacing: 10,
                children: [
                  Text('Email', style: Theme.of(context).textTheme.bodyMedium),
                  TextField(
                    controller: _controllerEmail,
                    style: Theme.of(context).textTheme.bodySmall,
                    decoration: InputDecoration(
                      hintText: 'example@mail.com',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  Text(
                    'Password',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),

                  /// Password field
                  TextField(
                    controller: _controllerPassword,
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

                  SizedBox(height: 5),

                  Consumer<AuthProvider>(
                    builder: (_, auth, __) {
                      return SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: auth.isLoading
                              ? null
                              : (hasTypingEmail && hasTypingPassword
                                    ? _handleLogin
                                    : null),
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.violet400,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 18),
                          ),
                          child: auth.isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text('Log in'),
                        ),
                      );
                    },
                  ),

                  SizedBox(height: 5),

                  Center(
                    child: GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Forgot Password?',
                        style: Theme.of(context).textTheme.bodyMedium,
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
