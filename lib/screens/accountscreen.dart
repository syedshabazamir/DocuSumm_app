import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:summarize_app/screens/signinscreen.dart';
import 'package:summarize_app/utils/colors.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String _fullName = '';
  String _email = '';
  String _initials = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      user = await FirebaseAuth.instance.authStateChanges().firstWhere(
        (u) => u != null,
      );
    }

    if (user == null || !mounted) return;

    final email = user.email ?? '';

    try {
      final doc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();

      final fullName = (doc.data()?['fullName'] ?? '') as String;

      final parts = fullName.trim().split(' ');
      final filtered = parts.where((String w) => w.isNotEmpty).take(2).toList();
      final initials = filtered.map((String w) => w[0].toUpperCase()).join();

      if (mounted) {
        setState(() {
          _fullName = fullName;
          _email = email;
          _initials = initials.isEmpty ? '?' : initials;
        });
      }
    } catch (e) {
      debugPrint('Error loading user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Account',
              style: TextStyle(
                color: AppColors.text,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Profile card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  // Avatar with real initials
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.amberDim,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.amber),
                    ),
                    child: Center(
                      child:
                          _initials.isEmpty
                              ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.amber,
                                ),
                              )
                              : Text(
                                _initials,
                                style: const TextStyle(
                                  color: AppColors.amberLight,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Real full name
                      Text(
                        _fullName.isEmpty ? '...' : _fullName,
                        style: const TextStyle(
                          color: AppColors.text,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      // Real email
                      Text(
                        _email.isEmpty ? '...' : _email,
                        style: const TextStyle(
                          color: AppColors.muted,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.amberDim,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.amberBorder),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.workspace_premium,
                              color: AppColors.amber,
                              size: 12,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Pro plan',
                              style: TextStyle(
                                color: AppColors.amberLight,
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                _statCard('—', 'documents'),
                const SizedBox(width: 10),
                _statCard('—', 'words read'),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                _statCard('—', 'time saved'),
                const SizedBox(width: 10),
                _statCard('—', 'this week'),
              ],
            ),

            const SizedBox(height: 24),

            const Text(
              'SETTINGS',
              style: TextStyle(
                color: AppColors.muted,
                fontSize: 11,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 10),

            _settingsItem(
              context,
              icon: Icons.person_outline,
              label: 'Edit profile',
              onTap: () => _comingSoon(context),
            ),
            _settingsItem(
              context,
              icon: Icons.notifications_outlined,
              label: 'Notifications',
              onTap: () => _comingSoon(context),
            ),
            _settingsItem(
              context,
              icon: Icons.credit_card_outlined,
              label: 'Billing & plan',
              onTap: () => _comingSoon(context),
            ),
            _settingsItem(
              context,
              icon: Icons.language_outlined,
              label: 'Language',
              onTap: () => _comingSoon(context),
            ),

            const SizedBox(height: 8),

            _settingsItem(
              context,
              icon: Icons.logout,
              label: 'Log out',
              isRed: true,
              onTap: () => _logout(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statCard(String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: const TextStyle(
                color: AppColors.amberLight,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(color: AppColors.muted, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _settingsItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isRed = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isRed ? Colors.redAccent : AppColors.muted,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: isRed ? Colors.redAccent : AppColors.text,
                  fontSize: 14,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: isRed ? Colors.redAccent : AppColors.muted,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  void _comingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Coming soon',
          style: TextStyle(color: AppColors.text),
        ),
        backgroundColor: AppColors.surface,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _logout(BuildContext context) async {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            backgroundColor: AppColors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Text(
              'Sign out',
              style: TextStyle(
                color: AppColors.text,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: const Text(
              'Are you sure you want to sign out?',
              style: TextStyle(color: AppColors.muted, fontSize: 14),
            ),
            actions: [
              // Cancel button
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: AppColors.muted),
                ),
              ),
              // Sign out button
              ElevatedButton(
                onPressed: () async {
                  Navigator.pop(ctx);
                  await FirebaseAuth.instance.signOut();
                  if (context.mounted) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const SignInScreen()),
                      (route) => false,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),
                child: const Text('Sign out'),
              ),
            ],
          ),
    );
  }
}
