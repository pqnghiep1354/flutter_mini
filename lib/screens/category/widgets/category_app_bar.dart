import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import '../../../widgets/circle_icon_button.dart';

class CategoryAppBar extends StatelessWidget {
  final String categoryName;

  const CategoryAppBar({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        children: [
          CircleIconButton(icon: Icons.arrow_back_ios_new_rounded, iconSize: 16, onTap: () => Navigator.pop(context)),
          Expanded(
            child: Text(categoryName, textAlign: TextAlign.center, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.primary)),
          ),
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.primary, width: 2)),
            child: ClipOval(
              child: Image.network(
                'https://i.pravatar.cc/100?img=5', fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(color: AppColors.primaryDark, child: const Icon(Icons.person, color: Colors.white, size: 20)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
