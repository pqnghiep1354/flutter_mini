import 'package:flutter/material.dart';
import '../apps/routers/router_name.dart';
import '../utils/app_colors.dart';

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const AppBottomNavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                icon: Icons.home_rounded,
                index: 0,
                currentIndex: currentIndex,
                onTap: () {
                  if (currentIndex != 0) {
                    Navigator.pushReplacementNamed(context, RouterName.home);
                  }
                },
              ),
              _NavItem(
                icon: Icons.favorite_border_rounded,
                index: 1,
                currentIndex: currentIndex,
                onTap: () {},
              ),
              _NavItem(
                icon: Icons.shopping_bag_outlined,
                index: 2,
                currentIndex: currentIndex,
                onTap: () {
                  if (currentIndex != 2) {
                    Navigator.pushReplacementNamed(context, RouterName.cart);
                  }
                },
              ),
              _NavItem(
                icon: Icons.notifications_none_rounded,
                index: 3,
                currentIndex: currentIndex,
                onTap: () {},
              ),
              _NavItem(
                icon: Icons.person_outline_rounded,
                index: 4,
                currentIndex: currentIndex,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final int index;
  final int currentIndex;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.index,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = index == currentIndex;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Icon(
          icon,
          color: isActive ? AppColors.primary : AppColors.textGrey,
          size: 26,
        ),
      ),
    );
  }
}
