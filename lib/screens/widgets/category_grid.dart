import 'package:flutter/material.dart';
import '../../models/category_model.dart';
import '../../widgets/category_card.dart';

class CategoryGrid extends StatelessWidget {
  final List<Category> categories;
  final void Function(Category) onTap;

  const CategoryGrid({super.key, required this.categories, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 1.4),
        itemCount: categories.length,
        itemBuilder: (_, i) =>
            CategoryCard(category: categories[i], onTap: () => onTap(categories[i])),
      ),
    );
  }
}
