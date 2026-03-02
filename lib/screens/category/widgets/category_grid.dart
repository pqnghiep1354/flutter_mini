import 'package:flutter/material.dart';
import '../../../models/coffee_model.dart';
import '../../../widgets/coffee_card.dart';

class CategoryGrid extends StatelessWidget {
  final List<CoffeeModel> coffees;

  const CategoryGrid({super.key, required this.coffees});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) => CoffeeCard(coffee: coffees[index]),
          childCount: coffees.length,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 14,
          childAspectRatio: 0.68,
        ),
      ),
    );
  }
}
