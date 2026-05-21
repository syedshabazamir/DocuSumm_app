import 'package:flutter/material.dart';
import 'package:summarize_app/utils/colors.dart';

class BottomNavBar extends StatelessWidget {
  final int index;
  final Function(int) onTap;

  const BottomNavBar({super.key, required this.index, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border, width: 0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          item(Icons.home_outlined, 'Home', 0),
          item(Icons.history, 'History', 1),
          item(Icons.account_circle_outlined, 'Account', 2),
        ],
      ),
    );
  }

  Widget item(IconData icon, String label, int i) {
    bool active = index == i;
    return GestureDetector(
      onTap: () => onTap(i),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 22,
            color: active ? AppColors.amber : AppColors.muted,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: active ? AppColors.amber : AppColors.muted,
              fontWeight: active ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
