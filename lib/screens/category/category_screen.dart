import 'package:flutter/material.dart';
import '../../models/coffee_model.dart';
import '../../utils/app_colors.dart';
import 'widgets/category_app_bar.dart';
import 'widgets/category_grid.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryName = ModalRoute.of(context)?.settings.arguments as String? ?? coffeeCategories.first;
    final coffees = sampleCoffees.where((c) => c.category == categoryName).toList();

    return Scaffold(
      backgroundColor: AppColors.bgDark,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: CategoryAppBar(categoryName: categoryName)),
            CategoryGrid(coffees: coffees),
          ],
        ),
      ),
    );
  }
}
