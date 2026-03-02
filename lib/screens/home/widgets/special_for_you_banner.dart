import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';

class SpecialForYouBanner extends StatelessWidget {
  const SpecialForYouBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Special for you', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textWhite)),
          const SizedBox(height: 14),
          _BannerCard(),
        ],
      ),
    );
  }
}

class _BannerCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(colors: [Color(0xFF6B4226), Color(0xFFC58B60)], begin: Alignment.centerLeft, end: Alignment.centerRight),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
              child: Image.network(
                'https://images.unsplash.com/photo-1461023058943-07fcbe16d735?w=300&q=80',
                height: 130, fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(color: const Color(0xFF6B4226)),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(6)),
                    child: const Text("Today's pick", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600)),
                  ),
                  const SizedBox(height: 8),
                  const Text('Specially mixed\nand brewed within\nyou must try', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500, height: 1.5)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
