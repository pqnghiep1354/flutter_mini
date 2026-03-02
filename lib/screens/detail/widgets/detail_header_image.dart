import 'package:flutter/material.dart';
import '../../../models/coffee_model.dart';
import '../../../utils/app_colors.dart';
import '../../../apps/routers/router_name.dart';
import '../../../widgets/circle_icon_button.dart';

class DetailHeaderImage extends StatelessWidget {
  final CoffeeModel coffee;

  const DetailHeaderImage({super.key, required this.coffee});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              coffee.imageUrl, fit: BoxFit.cover,
              loadingBuilder: (_, child, progress) {
                if (progress == null) return child;
                return Container(color: AppColors.bgCard, child: const Center(child: CircularProgressIndicator(color: AppColors.primary)));
              },
              errorBuilder: (_, __, ___) => Container(color: AppColors.bgCard, child: const Icon(Icons.coffee, size: 80, color: AppColors.textGrey)),
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter, end: Alignment.bottomCenter,
                  colors: [Colors.black.withOpacity(0.25), Colors.black.withOpacity(0.7)],
                  stops: const [0.3, 1.0],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleIconButton(icon: Icons.arrow_back_ios_new_rounded, iconSize: 16, bgColor: Colors.black45, onTap: () => Navigator.pop(context)),
                  Row(
                    children: [
                      CircleIconButton(icon: Icons.home_rounded, bgColor: Colors.black45, onTap: () => Navigator.pushNamedAndRemoveUntil(context, RouterName.root, (r) => false)),
                      const SizedBox(width: 10),
                      CircleIconButton(icon: Icons.favorite_rounded, iconColor: Colors.redAccent, bgColor: Colors.black45, onTap: () {}),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20, left: 20, right: 20,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(child: _NameInfo(coffee: coffee)),
                _InfoTags(coffee: coffee),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NameInfo extends StatelessWidget {
  final CoffeeModel coffee;
  const _NameInfo({required this.coffee});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(coffee.name, style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w800, letterSpacing: -0.5)),
        const SizedBox(height: 4),
        Text(coffee.subtitle, style: const TextStyle(color: Colors.white70, fontSize: 14)),
        const SizedBox(height: 10),
        Row(
          children: [
            const Icon(Icons.star_rounded, color: AppColors.star, size: 18),
            const SizedBox(width: 5),
            Text('${coffee.rating}', style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700)),
            Text('  (${coffee.reviewCount} reviews)', style: const TextStyle(color: Colors.white60, fontSize: 12)),
          ],
        ),
      ],
    );
  }
}

class _InfoTags extends StatelessWidget {
  final CoffeeModel coffee;
  const _InfoTags({required this.coffee});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _Tag(label: coffee.category),
        const SizedBox(height: 6),
        const _Tag(label: 'Chocolate'),
        const SizedBox(height: 6),
        const _Tag(label: 'Medium roast'),
      ],
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  const _Tag({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white24),
      ),
      child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w500)),
    );
  }
}
