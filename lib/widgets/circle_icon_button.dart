import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color? bgColor;
  final Color? iconColor;
  final double size;
  final double iconSize;

  const CircleIconButton({super.key, required this.icon, required this.onTap, this.bgColor, this.iconColor, this.size = 42, this.iconSize = 18});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: bgColor ?? AppColors.bgCard,
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 6, offset: const Offset(0, 2))],
        ),
        child: Icon(icon, size: iconSize, color: iconColor ?? AppColors.textWhite),
      ),
    );
  }
}
