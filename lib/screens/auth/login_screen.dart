
import 'package:flutter/material.dart';

import '../../data/mock_data.dart';
import '../../theme/app_theme.dart';
import 'signup_screen.dart';
import 'profile_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _login() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    Map<String, dynamic>? loggedUser;

    for (final user in MockData.mockUsers) {
      final email = (user['email'] ?? '')
          .toString()
          .toLowerCase()
          .trim();

      if (email == _emailController.text.toLowerCase().trim() &&
          user['password'] == _passwordController.text) {
        loggedUser = user;
        break;
      }
    }

    if (loggedUser == null) {
      _showMessage(
        'البريد الإلكتروني أو كلمة المرور غير صحيحة',
      );
      return;
    }

    MockData.currentUser = loggedUser;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfileScreen(),
      ),
    );
  }

  void _unavailableService() {
    _showMessage(
      'هذه الخدمة غير متاحة في النسخة التجريبية',
    );
  }

  Widget _buildSocialButton({
    required String title,
    required Widget icon,
  }) {
    return SizedBox(
      height: 38,
      child: ElevatedButton(
        onPressed: _unavailableService,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.fieldBackground,
          foregroundColor: AppColors.textPrimary,
          elevation: 0,
          minimumSize: const Size.fromHeight(38),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppMetrics.radius,
            ),
          ),
        ),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: AppText.body.copyWith(
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 15),

                  // Header
                  SizedBox(
                    height: 40,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Text(
                          'تسجيل الدخول',
                          style: AppText.body.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            onPressed: () =>
                                Navigator.pop(context),
                            icon: const Icon(
                              Icons.arrow_back,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Email Label
                  Text(
                    'عنوان الإيميل',
                    style: AppText.fieldLabel,
                  ),

                  const SizedBox(height: 7),

                  // Email Field
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.left,
                    style: AppText.body,
                    decoration: const InputDecoration(
                      hintText: 'example@email.com',
                      suffixIcon: Icon(
                        Icons.mail_outline,
                        color: AppColors.iconLight,
                        size: 19,
                      ),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty) {
                        return 'من فضلك أدخل البريد الإلكتروني';
                      }

                      final emailPattern =
                          RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

                      if (!emailPattern.hasMatch(value.trim())) {
                        return 'البريد الإلكتروني غير صحيح';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 12),

                  // Password Label
                  Text(
                    'الرقم السري',
                    style: AppText.fieldLabel,
                  ),

                  const SizedBox(height: 7),

                  // Password Field
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.left,
                    style: AppText.body,
                    decoration: InputDecoration(
                      hintText: '••••••••••',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscurePassword =
                                !_obscurePassword;
                          });
                        },
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: AppColors.iconLight,
                          size: 20,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'من فضلك أدخل كلمة المرور';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 25),

                  // Forgot Password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: _unavailableService,
                      child: Text(
                        'نسيت الرقم السري؟',
                        style: AppText.fieldLabel.copyWith(
                          color: AppColors.primaryAction,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Login Button
                  SizedBox(
                    height: AppMetrics.buttonHeight,
                    child: ElevatedButton(
                      onPressed: _login,
                      child: const Text('تسجيل الدخول'),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Or Divider
                  Row(
                    children: [
                      const Expanded(
                        child: Divider(
                          color: AppColors.border,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                        child: Text(
                          'أو',
                          style: AppText.body,
                        ),
                      ),
                      const Expanded(
                        child: Divider(
                          color: AppColors.border,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 35),

                  // Facebook
                  _buildSocialButton(
                    title: 'تسجيل الدخول باستخدام فيسبوك',
                    icon: const Icon(
                      Icons.facebook,
                      size: 25,
                      color: AppColors.iconLight,
                    ),
                  ),

                  const SizedBox(height: 14),

                  // Google
                  _buildSocialButton(
                    title: 'تسجيل الدخول باستخدام جوجل',
                    icon: Text(
                      'G',
                      style: AppText.button.copyWith(
                        fontSize: 22,
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  // Apple
                  _buildSocialButton(
                    title: 'تسجيل الدخول باستخدام Apple',
                    icon: const Icon(
                      Icons.phone_iphone,
                      size: 23,
                      color: AppColors.iconLight,
                    ),
                  ),

                  const SizedBox(height: 14),

                  // Phone
                  _buildSocialButton(
                    title: 'تسجيل الدخول باستخدام الهاتف',
                    icon: const Icon(
                      Icons.call,
                      size: 22,
                      color: AppColors.iconLight,
                    ),
                  ),

                  const SizedBox(height: 50),

                  Container(
                    height: 3,
                    color: AppColors.primaryAction,
                  ),

                  const SizedBox(height: 30),

                  // Sign Up Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'ليس لديك حساب؟',
                        style: AppText.body.copyWith(
                          fontSize: 15,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const SignupScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'سجل الآن',
                          style: AppText.body.copyWith(
                            fontSize: 15,
                            color: AppColors.primaryAction,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
