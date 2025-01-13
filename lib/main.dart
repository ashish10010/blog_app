import 'package:blog_app/core/theme/theme.dart';
import 'package:flutter/material.dart';

import 'features/auth/presentation/pages/sign_up_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog Application',
      theme: AppTheme.darkThemeMode,
      home: const SignUpPage(),
    );
  }
}

