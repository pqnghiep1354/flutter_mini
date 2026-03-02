import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 50,
              decoration: BoxDecoration(color: AppColors.inputBg, borderRadius: BorderRadius.circular(14)),
              child: const TextField(
                style: TextStyle(color: AppColors.textWhite, fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Search coffee...',
                  hintStyle: TextStyle(color: AppColors.textGrey, fontSize: 14),
                  prefixIcon: Icon(Icons.search_rounded, color: AppColors.textGrey, size: 22),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 50, height: 50,
            decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(14)),
            child: const Icon(Icons.tune_rounded, color: Colors.white, size: 22),
          ),
        ],
      ),
    );
  }
}
