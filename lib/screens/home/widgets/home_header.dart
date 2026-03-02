import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text_styles.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Row(
        children: [
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(color: AppColors.bgCard, borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.grid_view_rounded, color: AppColors.primary, size: 22),
          ),
          const Expanded(
            child: Column(
              children: [
                Text('Find the best', style: AppTextStyles.heading2, textAlign: TextAlign.center),
                Text('Coffee to your taste', style: TextStyle(fontSize: 13, color: AppColors.textGrey), textAlign: TextAlign.center),
              ],
            ),
          ),
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.primary, width: 2)),
            child: ClipOval(
              child: Image.network(
                'https://i.pravatar.cc/100?img=5',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(color: AppColors.primaryDark, child: const Icon(Icons.person, color: Colors.white, size: 22)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
