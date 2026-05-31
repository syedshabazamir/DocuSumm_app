import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:summarize_app/screens/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyBQnnvvjWvxeGXah83TnqaRS9901hBf7Gs",
      appId: "1:949061400829:android:3c1326cc7cda692ddce694",
      messagingSenderId: "949061400829",
      projectId: "cloudapp-c213f",
    ),
  );
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
