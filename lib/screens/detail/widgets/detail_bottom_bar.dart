import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import '../../../apps/routers/router_name.dart';

class DetailBottomBar extends StatelessWidget {
  final double totalPrice;
  final VoidCallback onAddToCart;

  const DetailBottomBar({super.key, required this.totalPrice, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      decoration: const BoxDecoration(
        color: AppColors.bgWhite,
        border: Border(top: BorderSide(color: Color(0xFFEEEEEE))),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Price', style: TextStyle(fontSize: 12, color: AppColors.textGrey)),
              const SizedBox(height: 2),
              Text('\$${totalPrice.toStringAsFixed(2)}', style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: AppColors.textDark)),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  onAddToCart();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Row(children: [Icon(Icons.check_circle, color: Colors.white), SizedBox(width: 10), Text('Added to cart!')]),
                      backgroundColor: AppColors.primary,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      action: SnackBarAction(label: 'View Cart', textColor: Colors.white, onPressed: () => Navigator.pushNamed(context, RouterName.root)),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary, foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  elevation: 4, shadowColor: AppColors.primary.withOpacity(0.4),
                ),
                child: const Text('Buy Now', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
