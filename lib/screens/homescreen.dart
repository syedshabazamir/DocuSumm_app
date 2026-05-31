import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:summarize_app/screens/accountscreen.dart';
import 'package:summarize_app/screens/historyscreen.dart';
import 'package:summarize_app/utils/colors.dart';
import 'package:summarize_app/widget/bottom_navig_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTab = 0;
  String _selectedStyle = 'Brief';
  String _userName = '';

  final List<String> _styles = ['Brief', 'Key points', 'Detailed', 'Executive'];

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final doc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    if (doc.exists && mounted) {
      final fullName = doc.data()?['fullName'] ?? '';
      // Show only first name
      setState(() {
        _userName = fullName.split(' ').first;
      });
    }
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) return 'Good morning';
    if (hour >= 12 && hour < 17) return 'Good afternoon';
    if (hour >= 17 && hour < 21) return 'Good evening';
    return 'Good night';
  }

  Widget _getScreen() {
    if (_selectedTab == 1) return const Historyscreen();
    if (_selectedTab == 2) return const AccountScreen();
    return _buildHomeBody();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: _getScreen()),
            BottomNavBar(
              index: _selectedTab,
              onTap: (i) => setState(() => _selectedTab = i),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeBody() {
    return Column(
      children: [
        // Top bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getGreeting(), // ← dynamic greeting
                    style: const TextStyle(
                      color: AppColors.muted,
                      fontSize: 13,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Hey, ',
                          style: TextStyle(
                            color: AppColors.text,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text:
                              _userName.isEmpty
                                  ? '...'
                                  : _userName, // ← real name
                          style: const TextStyle(
                            color: AppColors.amberLight,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.border),
                ),
                child: const Icon(
                  Icons.notifications_outlined,
                  color: AppColors.muted,
                  size: 20,
                ),
              ),
            ],
          ),
        ),

        // Scrollable content — rest stays exactly the same
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 36),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: const Column(
                      children: [
                        Icon(
                          Icons.cloud_upload_outlined,
                          color: AppColors.muted,
                          size: 36,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Tap to upload a document',
                          style: TextStyle(
                            color: AppColors.text,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'PDF · DOCX · TXT · up to 25MB',
                          style: TextStyle(
                            color: AppColors.muted,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                const Text(
                  'SUMMARY STYLE',
                  style: TextStyle(
                    color: AppColors.muted,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 10),

                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children:
                      _styles.map((style) {
                        final isSelected = _selectedStyle == style;
                        return GestureDetector(
                          onTap: () => setState(() => _selectedStyle = style),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  isSelected
                                      ? AppColors.amberDim
                                      : AppColors.surface,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color:
                                    isSelected
                                        ? AppColors.amber
                                        : AppColors.border,
                                width: isSelected ? 1.5 : 1,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  _styleIcon(style),
                                  size: 14,
                                  color:
                                      isSelected
                                          ? AppColors.amber
                                          : AppColors.muted,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  style,
                                  style: TextStyle(
                                    color:
                                        isSelected
                                            ? AppColors.amber
                                            : AppColors.muted,
                                    fontSize: 13,
                                    fontWeight:
                                        isSelected
                                            ? FontWeight.w600
                                            : FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                ),

                const SizedBox(height: 28),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.auto_awesome, size: 16),
                    label: const Text(
                      'Generate summary',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.amber,
                      disabledBackgroundColor: AppColors.surface,
                      disabledForegroundColor: AppColors.muted,
                      foregroundColor: const Color(0xFF1A0E00),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  IconData _styleIcon(String style) {
    switch (style) {
      case 'Key points':
        return Icons.list;
      case 'Detailed':
        return Icons.article_outlined;
      case 'Executive':
        return Icons.bar_chart;
      default:
        return Icons.align_horizontal_left;
    }
  }
}
