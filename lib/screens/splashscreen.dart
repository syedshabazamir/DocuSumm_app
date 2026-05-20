import 'package:flutter/material.dart';
import 'package:summarize_app/screens/signinscreen.dart';
import 'package:summarize_app/utils/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => SignInScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo icon
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: AppColors.amberDim,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.amberBorder),
              ),
              child: const Icon(
                Icons.description_outlined,
                color: AppColors.amber,
              ),
            ),
            const SizedBox(height: 12),

            // App name
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: 'Docu',
                    style: TextStyle(
                      color: AppColors.amberLight,
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: 'Summ',
                    style: TextStyle(color: AppColors.muted, fontSize: 30),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),

            // Tagline
            const Text(
              'AI-powered document summaries',
              style: TextStyle(color: AppColors.muted, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
