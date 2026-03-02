import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';

class ChocolateSelector extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onChanged;

  static const _options = ['White Chocolate', 'Milk Chocolate', 'Dark Chocolate'];

  const ChocolateSelector({super.key, required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Choice of Chocolate', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textDark)),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _options.map((option) {
              final isSelected = option == selected;
              return GestureDetector(
                onTap: () => onChanged(option),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: isSelected ? AppColors.primary : Colors.grey.shade300),
                  ),
                  child: Text(option, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: isSelected ? Colors.white : AppColors.textHint)),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
