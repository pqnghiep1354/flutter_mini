import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class QuantityCounter extends StatelessWidget {
  final int quantity;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;
  final bool darkMode;

  const QuantityCounter({
    super.key,
    required this.quantity,
    required this.onDecrease,
    required this.onIncrease,
    this.darkMode = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _CounterBtn(
          icon: Icons.remove,
          onTap: onDecrease,
          darkMode: darkMode,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Text(
            '$quantity',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: darkMode ? AppColors.textWhite : AppColors.textDark,
            ),
          ),
        ),
        _CounterBtn(
          icon: Icons.add,
          onTap: onIncrease,
          filled: true,
          darkMode: darkMode,
        ),
      ],
    );
  }
}

class _CounterBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool filled;
  final bool darkMode;

  const _CounterBtn({
    required this.icon,
    required this.onTap,
    this.filled = false,
    this.darkMode = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: filled
              ? AppColors.primary
              : (darkMode ? AppColors.bgCardLight : AppColors.bgLight),
          borderRadius: BorderRadius.circular(9),
          border: filled
              ? null
              : Border.all(
                  color: darkMode
                      ? AppColors.divider
                      : Colors.grey.shade300,
                ),
        ),
        child: Icon(
          icon,
          size: 15,
          color: filled
              ? AppColors.textWhite
              : (darkMode ? AppColors.textGreyLight : AppColors.textDark),
        ),
      ),
    );
  }
}
