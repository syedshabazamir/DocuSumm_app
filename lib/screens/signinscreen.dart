import 'package:flutter/material.dart';
import 'package:summarize_app/screens/signupscreen.dart';
import 'package:summarize_app/utils/colors.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  void _signIn() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isLoading = false);
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),

              // Logo icon
              Center(
                child: Container(
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
              ),
              const SizedBox(height: 12),

              // App name
              Center(
                child: RichText(
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
              ),
              const SizedBox(height: 4),
              const Center(
                child: Text(
                  'AI-powered document summaries',
                  style: TextStyle(color: AppColors.muted, fontSize: 15),
                ),
              ),

              const SizedBox(height: 40),

              // Heading
              const Text(
                'Sign in',
                style: TextStyle(
                  color: AppColors.text,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Email field
              TextField(
                controller: _emailController,
                style: const TextStyle(color: AppColors.surface),
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: const TextStyle(color: AppColors.muted),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  filled: true,
                  fillColor: AppColors.text,
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                    color: AppColors.surface,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.amber),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.amber),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: AppColors.amber,
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Password field
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                style: const TextStyle(color: AppColors.surface),
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: const TextStyle(color: AppColors.muted),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  filled: true,
                  fillColor: AppColors.text,
                  prefixIcon: const Icon(
                    Icons.lock_outlined,
                    color: AppColors.surface,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: AppColors.surface,
                    ),
                    onPressed:
                        () => setState(
                          () => _obscurePassword = !_obscurePassword,
                        ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.amber),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.amber),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: AppColors.amber,
                      width: 2,
                    ),
                  ),
                ),
              ),

              // Forgot password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Forgot password?',
                    style: TextStyle(color: AppColors.amberLight),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // Sign in button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _signIn,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.amber,
                    foregroundColor: const Color(0xFF1A0E00),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child:
                      _isLoading
                          ? const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Color(0xFF1A0E00),
                          )
                          : const Text(
                            'Sign in',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                ),
              ),

              const SizedBox(height: 24),

              // Sign up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(color: AppColors.muted),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => SignUpScreen()),
                      );
                    },
                    child: const Text(
                      'Create an account',
                      style: TextStyle(
                        color: AppColors.amberLight,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
