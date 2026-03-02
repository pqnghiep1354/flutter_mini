import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';

class CategoryTabBar extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final ValueChanged<String> onCategoryChanged;

  const CategoryTabBar({super.key, required this.categories, required this.selectedCategory, required this.onCategoryChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cat = categories[index];
          final isSelected = cat == selectedCategory;
          return GestureDetector(
            onTap: () => onCategoryChanged(cat),
            child: Container(
              margin: const EdgeInsets.only(right: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(cat, style: TextStyle(fontSize: 14, fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400, color: isSelected ? AppColors.primary : AppColors.textGrey)),
                  const SizedBox(height: 6),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: isSelected ? 24 : 0, height: 3,
                    decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(3)),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
