import 'package:flutter/material.dart';
import 'package:summarize_app/screens/signinscreen.dart';
import 'package:summarize_app/screens/splashscreen.dart';

void main() {
  runApp(const DocuSummApp());
}

class DocuSummApp extends StatelessWidget {
  const DocuSummApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DocuSumm',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0D0C0A),
        fontFamily: 'SF Pro Display',
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFE8A020),
          surface: Color(0xFF161512),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
