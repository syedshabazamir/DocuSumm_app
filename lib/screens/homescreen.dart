import 'package:flutter/material.dart';
import 'package:summarize_app/screens/accountscreen.dart';
import 'package:summarize_app/screens/historyscreen.dart';
import 'package:summarize_app/utils/colors.dart';
import 'package:summarize_app/widget/bottom_navig_bar.dart';
import 'package:summarize_app/screens/historyscreen.dart';
import 'package:summarize_app/screens/accountscreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTab = 0;
  String _selectedStyle = 'Brief';

  final List<String> _styles = ['Brief', 'Key points', 'Detailed', 'Executive'];

  // all screens listed here
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
            // show the current screen
            Expanded(child: _getScreen()),

            // Bottom nav bar
            BottomNavBar(
              index: _selectedTab,
              onTap: (i) => setState(() => _selectedTab = i),
            ),
          ],
        ),
      ),
    );
  }

  // ── Home body ────────────────────────────────────────────
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
                  const Text(
                    'Good morning',
                    style: TextStyle(color: AppColors.muted, fontSize: 13),
                  ),
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Hey, ',
                          style: TextStyle(
                            color: AppColors.text,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: 'Alex',
                          style: TextStyle(
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

        // Scrollable content
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Upload box
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

                // Summary style label
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

                // Style pills
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

                // Generate button
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
