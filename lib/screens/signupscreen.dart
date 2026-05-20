import 'package:flutter/material.dart';
import 'package:summarize_app/utils/colors.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  void _signUp() async {
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
              const SizedBox(height: 30),

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
                    size: 30,
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
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: 'Summ',
                        style: TextStyle(
                          color: AppColors.text,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 4),
              const Center(
                child: Text(
                  'AI-powered document summaries',
                  style: TextStyle(color: AppColors.muted, fontSize: 12),
                ),
              ),

              const SizedBox(height: 32),

              // Heading
              const Text(
                'Create account',
                style: TextStyle(
                  color: AppColors.text,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Full name label + field
              const Text(
                'FULL NAME',
                style: TextStyle(
                  color: AppColors.text,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: _nameController,
                style: const TextStyle(color: AppColors.text),
                decoration: InputDecoration(
                  hintText: 'Alex Johnson',
                  hintStyle: const TextStyle(color: AppColors.muted),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  filled: true,
                  fillColor: AppColors.text,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: AppColors.amber,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // Email label + field
              const Text(
                'EMAIL',
                style: TextStyle(
                  color: AppColors.text,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: AppColors.text),
                decoration: InputDecoration(
                  hintText: 'you@example.com',
                  hintStyle: const TextStyle(color: AppColors.muted),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  filled: true,
                  fillColor: AppColors.text,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: AppColors.amber,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // Password label + field
              const Text(
                'PASSWORD',
                style: TextStyle(
                  color: AppColors.text,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                style: const TextStyle(color: AppColors.text),
                decoration: InputDecoration(
                  hintText: 'Create password',
                  hintStyle: const TextStyle(color: AppColors.muted),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  filled: true,
                  fillColor: AppColors.text,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: AppColors.muted,
                      size: 18,
                    ),
                    onPressed:
                        () => setState(
                          () => _obscurePassword = !_obscurePassword,
                        ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: AppColors.amber,
                      width: 1.5,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // Get started button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _signUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.amber,
                    disabledBackgroundColor: AppColors.dim,
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
                            'Get started',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                ),
              ),

              const SizedBox(height: 24),

              // Sign in link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Have an account?',
                    style: TextStyle(color: AppColors.muted, fontSize: 13),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Sign in',
                      style: TextStyle(
                        color: AppColors.amberLight,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
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
