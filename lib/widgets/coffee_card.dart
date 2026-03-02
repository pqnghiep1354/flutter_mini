import 'package:flutter/material.dart';
import '../models/coffee_model.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../apps/routers/router_name.dart';
import 'rating_badge.dart';

class CoffeeCard extends StatelessWidget {
  final CoffeeModel coffee;

  const CoffeeCard({super.key, required this.coffee});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        RouterName.detail,
        arguments: coffee,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          color: AppColors.bgCard,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _CardImage(coffee: coffee),
              _CardInfo(coffee: coffee),
            ],
          ),
        ),
      ),
    );
  }
}

class _CardImage extends StatelessWidget {
  final CoffeeModel coffee;
  const _CardImage({required this.coffee});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 1.1,
          child: Image.network(
            coffee.imageUrl,
            width: double.infinity,
            fit: BoxFit.cover,
            loadingBuilder: (_, child, progress) {
              if (progress == null) return child;
              return Container(
                color: AppColors.bgCardLight,
                child: const Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              );
            },
            errorBuilder: (_, __, ___) => Container(
              color: AppColors.bgCardLight,
              child: const Icon(
                Icons.coffee,
                color: AppColors.textGrey,
                size: 36,
              ),
            ),
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: RatingBadge(rating: coffee.rating),
        ),
      ],
    );
  }
}

class _CardInfo extends StatelessWidget {
  final CoffeeModel coffee;
  const _CardInfo({required this.coffee});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            coffee.name,
            style: AppTextStyles.label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            coffee.subtitle,
            style: AppTextStyles.caption,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${coffee.price.toStringAsFixed(2)}',
                style: AppTextStyles.price,
              ),
              _AddButton(coffee: coffee),
            ],
          ),
        ],
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final CoffeeModel coffee;
  const _AddButton({required this.coffee});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        RouterName.detail,
        arguments: coffee,
      ),
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(9),
        ),
        child: const Icon(Icons.add, color: Colors.white, size: 17),
      ),
    );
  }
}
