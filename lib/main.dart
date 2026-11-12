import 'package:flutter/material.dart';
import 'package:syanti_app/screens/auth/welcome_screen.dart';

import 'theme/app_theme.dart';

void main() {
  runApp(const SyantiApp());
}

class SyantiApp extends StatelessWidget {
  const SyantiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'صيانتي',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      // التطبيق عربي بالكامل، فالاتجاه يتثبت مرة واحدة هنا بدل كل شاشة
      builder: (BuildContext context, Widget? child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child ?? const SizedBox.shrink(),
        );
      },
      home: const WelcomeScreen(),
    );
  }
}
