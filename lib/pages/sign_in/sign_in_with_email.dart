import 'package:flutter/material.dart';
import 'package:hackathon_app/color/app_colors.dart';

class SignInWithEmail extends StatefulWidget {
  const SignInWithEmail({super.key});

  @override
  State<SignInWithEmail> createState() => _SignInWithEmailState();
}

class _SignInWithEmailState extends State<SignInWithEmail> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  bool _obscure = true;
  bool get hasTypingEmail => _controllerEmail.text.isNotEmpty;
  bool get hasTypingPassword => _controllerEmail.text.isNotEmpty;

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

                  // Row(
                  //   spacing: 2,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Icon(Icons.error_outline, color: AppColors.redPrimary),
                  //     Expanded(
                  //       child: Text(
                  //         'Oops! Email or password incorrect try another one.',
                  //         style: Theme.of(context).textTheme.bodySmall
                  //             ?.copyWith(color: AppColors.redPrimary),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        hasTypingEmail && hasTypingPassword
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignInWithEmail(),
                                ),
                              )
                            : null;
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: hasTypingEmail && hasTypingPassword
                            ? AppColors.violet400
                            : AppColors.violet200,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 18),
                      ),
                      child: Text(
                        'Log in',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                      ),
                    ),
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
