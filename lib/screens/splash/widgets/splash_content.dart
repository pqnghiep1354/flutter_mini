import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Stay Focused',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: AppColors.textDark, letterSpacing: -0.5),
        ),
        const SizedBox(height: 12),
        Text(
          'Get the cup filled of your choice to stay\nfocused and awake. Different type of coffee\nmenu, hot latte cappuccino',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: AppColors.textDark.withOpacity(0.65), height: 1.7),
        ),
      ],
    );
  }
}
