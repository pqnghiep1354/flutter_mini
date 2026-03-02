import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTapItem;

  const AppBottomNavBar({super.key, required this.currentIndex, required this.onTapItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.bgCard,
        border: Border(top: BorderSide(color: AppColors.divider, width: 0.5)),
      ),
      child: SafeArea(
        child: SizedBox(
          height: 60,
          child: Row(
            children: [
              _NavItem(icon: Icons.home_rounded,               label: 'Home',     index: 0, currentIndex: currentIndex, onTap: onTapItem),
              _NavItem(icon: Icons.favorite_border_rounded,    label: 'Wishlist', index: 1, currentIndex: currentIndex, onTap: onTapItem),
              _NavItem(icon: Icons.shopping_bag_outlined,      label: 'Cart',     index: 2, currentIndex: currentIndex, onTap: onTapItem, showBadge: true),
              _NavItem(icon: Icons.notifications_none_rounded, label: 'Alerts',   index: 3, currentIndex: currentIndex, onTap: onTapItem),
              _NavItem(icon: Icons.person_outline_rounded,     label: 'Profile',  index: 4, currentIndex: currentIndex, onTap: onTapItem),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final bool showBadge;

  const _NavItem({required this.icon, required this.label, required this.index, required this.currentIndex, required this.onTap, this.showBadge = false});

  @override
  Widget build(BuildContext context) {
    final isActive = index == currentIndex;
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => onTap(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(icon, size: 24, color: isActive ? AppColors.primary : AppColors.textGrey),
                if (showBadge)
                  Positioned(
                    top: -4, right: -6,
                    child: Container(width: 10, height: 10, decoration: const BoxDecoration(color: AppColors.orange, shape: BoxShape.circle)),
                  ),
              ],
            ),
            const SizedBox(height: 3),
            Text(label, style: TextStyle(fontSize: 10, color: isActive ? AppColors.primary : AppColors.textGrey, fontWeight: isActive ? FontWeight.w600 : FontWeight.normal)),
          ],
        ),
      ),
    );
  }
}
