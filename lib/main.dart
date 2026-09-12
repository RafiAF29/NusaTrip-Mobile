import 'package:flutter/material.dart';
import 'pages/splash_page.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const NusaTripApp());
}

class NusaTripApp extends StatelessWidget {
  const NusaTripApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NusaTrip',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashPage(),
    );
  }
}
