
import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: const Center(
        child: Text(
          'Sign Up',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryAction,
          ),
        ),
      ),
    );
  }
}
