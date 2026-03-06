import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../providers/settings_provider.dart';
import 'widgets/category_toggle_tile.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // ── UI ──
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: Text('Settings',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1A1A2E),
        scrolledUnderElevation: 0,
      ),
      body: Consumer<SettingsProvider>(
        builder: (context, settings, child) {
          return _buildBody(settings);
        },
      ),
    );
  }

  Widget _buildBody(SettingsProvider settings) {
    if (settings.isCategoriesLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (settings.categoriesError != null) {
      return _buildError(settings);
    }
    return _buildContent(settings);
  }

  Widget _buildError(SettingsProvider settings) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(Icons.error_outline, size: 48.sp, color: Colors.grey),
        SizedBox(height: 12.h),
        Text('Failed to load categories',
            style: TextStyle(color: Colors.grey[600], fontSize: 14.sp)),
        SizedBox(height: 12.h),
        TextButton(
          onPressed: () => settings.loadCategories(),
          child: const Text('Retry'),
        ),
      ]),
    );
  }

  Widget _buildContent(SettingsProvider settings) {
    final categories = settings.categories;

    return Column(children: [
      // Actions row
      Padding(
        padding: EdgeInsets.fromLTRB(16.w, 12.h, 8.w, 0),
        child: Row(children: [
          Expanded(
            child: Text(
              '${categories.length - settings.hiddenCategoryIds.length} of ${categories.length} categories visible',
              style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500),
            ),
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, size: 22.sp),
            onSelected: (value) {
              if (value == 'show_all') {
                settings.showAll();
              } else if (value == 'hide_all') {
                settings.hideAll(categories.map((c) => c.id).toList());
              }
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                value: 'show_all',
                child: Row(children: [
                  Icon(Icons.visibility,
                      size: 20.sp, color: const Color(0xFF6C63FF)),
                  SizedBox(width: 10.w),
                  const Text('Show All'),
                ]),
              ),
              PopupMenuItem(
                value: 'hide_all',
                child: Row(children: [
                  Icon(Icons.visibility_off, size: 20.sp, color: Colors.grey),
                  SizedBox(width: 10.w),
                  const Text('Hide All'),
                ]),
              ),
            ],
          ),
        ]),
      ),
      // Info card
      Container(
        margin: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 12.h),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: const Color(0xFF6C63FF).withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: const Color(0xFF6C63FF).withValues(alpha: 0.2),
          ),
        ),
        child: Row(children: [
          Icon(Icons.info_outline, color: const Color(0xFF6C63FF), size: 20.sp),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              'Toggle categories to show or hide them on the home screen.',
              style: TextStyle(
                  color: Colors.grey[700], fontSize: 13.sp, height: 1.4),
            ),
          ),
        ]),
      ),
      // Category list
      Expanded(
        child: ListView.builder(
          padding: EdgeInsets.only(bottom: 16.h),
          itemCount: categories.length,
          itemBuilder: (_, i) => CategoryToggleTile(
            category: categories[i],
            isVisible: settings.isCategoryVisible(categories[i].id),
            onToggle: () => settings.toggleCategory(categories[i].id),
          ),
        ),
      ),
    ]);
  }
}
