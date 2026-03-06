import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../config/routes/app_router.dart';
import 'home_header.dart';

class HomeAppBarWidget extends StatelessWidget {
  const HomeAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 8.w, 0),
      child: Row(
        children: [
          Builder(
            builder: (ctx) => IconButton(
              icon:
                  Icon(Icons.menu, color: const Color(0xFF1A1A2E), size: 26.sp),
              onPressed: () => Scaffold.of(ctx).openDrawer(),
              padding: EdgeInsets.only(left: 12.w),
            ),
          ),
          const Expanded(child: HomeHeader()),
          IconButton(
            icon:
                Icon(Icons.search, color: const Color(0xFF6C63FF), size: 26.sp),
            onPressed: () => Navigator.pushNamed(context, AppRouter.search),
            tooltip: 'Search',
          ),
          IconButton(
            icon: Icon(Icons.settings_outlined,
                color: const Color(0xFF6C63FF), size: 26.sp),
            onPressed: () => Navigator.pushNamed(context, AppRouter.settings),
            tooltip: 'Settings',
          ),
        ],
      ),
    );
  }
}
