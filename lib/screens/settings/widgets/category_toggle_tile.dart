import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../models/category_model.dart';

class CategoryToggleTile extends StatelessWidget {
  final Category category;
  final bool isVisible;
  final VoidCallback onToggle;

  const CategoryToggleTile({
    super.key,
    required this.category,
    required this.isVisible,
    required this.onToggle,
  });

  Color _getColor() {
    const colors = [
      Color(0xFF6C63FF),
      Color(0xFFFF6584),
      Color(0xFF43E97B),
      Color(0xFFFA709A),
      Color(0xFF667EEA),
      Color(0xFFF093FB),
      Color(0xFF4FACFE),
      Color(0xFFF5576C),
      Color(0xFF0BA360),
      Color(0xFFFFA726),
    ];
    return colors[category.id % colors.length];
  }

  IconData _getIcon() {
    const icons = [
      Icons.article_outlined,
      Icons.sports_soccer,
      Icons.movie_outlined,
      Icons.science_outlined,
      Icons.computer,
      Icons.health_and_safety,
      Icons.travel_explore,
      Icons.restaurant,
      Icons.music_note,
      Icons.school,
    ];
    return icons[category.id % icons.length];
  }

  @override
  Widget build(BuildContext context) {
    final color = _getColor();
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: isVisible ? Colors.white : Colors.grey[100],
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: isVisible
            ? [
                BoxShadow(
                  color: color.withValues(alpha: 0.15),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                )
              ]
            : [],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
        leading: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: isVisible ? color.withValues(alpha: 0.15) : Colors.grey[200],
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(
            _getIcon(),
            color: isVisible ? color : Colors.grey,
            size: 24.sp,
          ),
        ),
        title: Text(
          category.name,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15.sp,
            color: isVisible ? const Color(0xFF1A1A2E) : Colors.grey,
          ),
        ),
        subtitle: category.totalArticles != null
            ? Text(
                '${category.totalArticles} articles',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: isVisible ? Colors.grey[600] : Colors.grey[400],
                ),
              )
            : null,
        trailing: Switch.adaptive(
          value: isVisible,
          onChanged: (_) => onToggle(),
          activeTrackColor: const Color(0xFF6C63FF),
        ),
      ),
    );
  }
}
