import 'package:flutter/material.dart';
import '../../models/coffee_model.dart';
import '../../utils/app_colors.dart';
import '../../apps/routers/router_name.dart';

class CoffeeCard extends StatelessWidget {
  final CoffeeModel coffee;

  const CoffeeCard({super.key, required this.coffee});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RouterName.detail, arguments: coffee);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image + rating
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: Image.network(
                    coffee.imageUrl,
                    height: 110,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 110,
                      color: Colors.brown.shade100,
                      child: const Icon(Icons.coffee, size: 40, color: Colors.brown),
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, color: Colors.orange, size: 12),
                        const SizedBox(width: 2),
                        Text(
                          coffee.rating.toString(),
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Info
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
              child: Text(
                coffee.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 2, 10, 0),
              child: Text(
                coffee.subtitle,
                style: TextStyle(
                  fontSize: 11,
                  color: AppColors.textGrey,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 6, 8, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${coffee.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.add, color: Colors.white, size: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
