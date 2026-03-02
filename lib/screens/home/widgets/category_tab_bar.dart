import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';

class CategoryTabBar extends StatefulWidget {
  final List<String> categories;
  final Function(String) onCategorySelected;

  const CategoryTabBar({
    super.key,
    required this.categories,
    required this.onCategorySelected,
  });

  @override
  State<CategoryTabBar> createState() => _CategoryTabBarState();
}

class _CategoryTabBarState extends State<CategoryTabBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.categories.length,
        itemBuilder: (context, index) {
          final isSelected = index == _selectedIndex;
          return GestureDetector(
            onTap: () {
              setState(() => _selectedIndex = index);
              widget.onCategorySelected(widget.categories[index]);
            },
            child: Container(
              margin: const EdgeInsets.only(right: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.categories[index],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      color: isSelected ? AppColors.primary : AppColors.textGrey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (isSelected)
                    Container(
                      height: 2,
                      width: 20,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(2),
                      ),
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
