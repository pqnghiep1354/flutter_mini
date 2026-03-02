import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class RatingBadge extends StatelessWidget {
  final double rating;

  const RatingBadge({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.55), borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star_rounded, color: AppColors.star, size: 13),
          const SizedBox(width: 3),
          Text(rating.toStringAsFixed(1), style: const TextStyle(color: AppColors.textWhite, fontSize: 11, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
