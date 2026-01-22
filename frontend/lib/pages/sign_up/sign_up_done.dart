import 'package:flutter/material.dart';
import 'package:hackathon_app/color/app_colors.dart';
import 'package:hackathon_app/pages/sign_in/sign_in_page.dart';

class SignUpDone extends StatelessWidget {
  const SignUpDone({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            SizedBox(height: 80),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                Text(
                  'Your account was successfully created!',
                  style: Theme.of(
                    context,
                  ).textTheme.headlineLarge?.copyWith(color: AppColors.black5),
                  textAlign: TextAlign.center,
                ),
                Image.asset('assets/images/partyPopper.png'),
                Text(
                  'One step into a more focused mind',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: AppColors.black5),
                  textAlign: TextAlign.center,
                ),
              ],
            ),

            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignInPage()),
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
                  'Log in',
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
    );
  }
}
