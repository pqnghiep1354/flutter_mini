import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import '../../../widgets/quantity_counter.dart';

class SizeSelector extends StatelessWidget {
  final String selectedSize;
  final int quantity;
  final ValueChanged<String> onSizeChanged;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  static const _sizes = ['S', 'M', 'L'];

  const SizeSelector({super.key, required this.selectedSize, required this.quantity, required this.onSizeChanged, required this.onDecrease, required this.onIncrease});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Size', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textDark)),
              const SizedBox(height: 12),
              Row(
                children: _sizes.map((size) {
                  final isSelected = size == selectedSize;
                  return GestureDetector(
                    onTap: () => onSizeChanged(size),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      margin: const EdgeInsets.only(right: 10),
                      width: 46, height: 46,
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: isSelected ? AppColors.primary : Colors.grey.shade300),
                        boxShadow: isSelected ? [BoxShadow(color: AppColors.primary.withOpacity(0.35), blurRadius: 8, offset: const Offset(0, 4))] : null,
                      ),
                      child: Center(child: Text(size, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: isSelected ? Colors.white : AppColors.textHint))),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        QuantityCounter(quantity: quantity, onDecrease: onDecrease, onIncrease: onIncrease, darkMode: false),
      ],
    );
  }
}
