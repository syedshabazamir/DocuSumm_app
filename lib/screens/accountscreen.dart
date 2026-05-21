import 'package:flutter/material.dart';
import 'package:summarize_app/screens/signinscreen.dart';
import 'package:summarize_app/utils/colors.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
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
                  // Avatar
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.amberDim,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.amber),
                    ),
                    child: const Center(
                      child: Text(
                        'A',
                        style: TextStyle(
                          color: AppColors.amberLight,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Alex Johnson',
                        style: TextStyle(
                          color: AppColors.text,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Text(
                        'alex@example.com',
                        style: TextStyle(color: AppColors.muted, fontSize: 12),
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

            // Stats grid — numbers hidden until Firebase
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

            // Settings label
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

            // Settings items
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

            // Logout
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

  // stat card widget
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

  // settings row widget
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

  // coming soon snackbar
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

  // logout and go to sign in
  void _logout(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const SignInScreen()),
      (route) => false,
    );
  }
}
