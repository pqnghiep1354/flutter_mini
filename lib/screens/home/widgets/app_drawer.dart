import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../config/routes/app_router.dart';
import '../../../providers/auth_provider.dart';
import 'drawer_item.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Consumer<AuthProvider>(
        builder: (context, auth, child) {
          return Column(children: [
            _buildHeader(context, auth),
            SizedBox(height: 8.h),
            DrawerItem(
              icon: Icons.home_outlined,
              label: 'Home',
              onTap: () => Navigator.pop(context),
            ),
            DrawerItem(
              icon: Icons.favorite_outline,
              label: 'Favorites',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRouter.favorites);
              },
            ),
            // Profile — chỉ hiện khi đã đăng nhập
            if (auth.isLoggedIn)
              DrawerItem(
                icon: Icons.person_outline,
                label: 'Profile',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, AppRouter.profile);
                },
              ),
            DrawerItem(
              icon: Icons.settings_outlined,
              label: 'Settings',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRouter.settings);
              },
            ),
            // Admin — chỉ hiện khi đã đăng nhập
            if (auth.isLoggedIn)
              DrawerItem(
                icon: Icons.edit_note,
                label: 'Create Post',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, AppRouter.admin);
                },
              ),
            const Spacer(),
            const Divider(height: 1),
            DrawerItem(
              icon: auth.isLoggedIn ? Icons.logout : Icons.login,
              label: auth.isLoggedIn ? 'Logout' : 'Sign In',
              color: auth.isLoggedIn ? Colors.red : const Color(0xFF6C63FF),
              onTap: () {
                Navigator.pop(context);
                if (auth.isLoggedIn) {
                  auth.logout();
                } else {
                  Navigator.pushNamed(context, AppRouter.login);
                }
              },
            ),
            SizedBox(height: 16.h),
          ]);
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AuthProvider auth) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 24.h,
        left: 20.w,
        right: 20.w,
        bottom: 24.h,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF6C63FF), Color(0xFF4FACFE)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 32.r,
            backgroundColor: Colors.white.withValues(alpha: 0.2),
            child: Icon(
              auth.isLoggedIn ? Icons.person : Icons.person_outline,
              color: Colors.white,
              size: 36.sp,
            ),
          ),
          SizedBox(height: 14.h),
          Text(
            auth.isLoggedIn ? auth.user!.name : 'Guest',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            auth.isLoggedIn ? auth.user!.email : 'Sign in to unlock features',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 13.sp,
            ),
          ),
        ],
      ),
    );
  }
}
