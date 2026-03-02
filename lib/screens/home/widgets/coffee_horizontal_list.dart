import 'package:flutter/material.dart';
import '../../../models/coffee_model.dart';
import '../../../utils/app_colors.dart';
import '../../../apps/routers/router_name.dart';
import '../../../widgets/coffee_card.dart';

class CoffeeHorizontalList extends StatelessWidget {
  final List<CoffeeModel> coffees;
  final String category;

  const CoffeeHorizontalList({
    super.key,
    required this.coffees,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (coffees.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: Text(
              'No items in this category',
              style: TextStyle(color: AppColors.textGrey),
            ),
          )
        else
          SizedBox(
            // Tăng height để card không bị overflow
            height: 240,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: coffees.length,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.only(
                  right: index < coffees.length - 1 ? 14 : 0,
                ),
                child: SizedBox(
                  // Tăng width để tỉ lệ phù hợp với card
                  width: 160,
                  child: CoffeeCard(coffee: coffees[index]),
                ),
              ),
            ),
          ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(
              context,
              RouterName.category,
              arguments: category,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text(
                  'See all',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 4),
                Icon(Icons.arrow_forward_ios_rounded,
                    color: AppColors.primary, size: 12),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
