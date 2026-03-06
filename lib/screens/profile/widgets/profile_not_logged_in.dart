import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileNotLoggedIn extends StatelessWidget {
  const ProfileNotLoggedIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person_off_outlined, size: 64.sp, color: Colors.grey[300]),
          SizedBox(height: 16.h),
          Text('Bạn chưa đăng nhập',
              style: TextStyle(color: Colors.grey[500], fontSize: 16.sp)),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/login'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6C63FF),
              foregroundColor: Colors.white,
            ),
            child: const Text('Đăng nhập'),
          ),
        ],
      ),
    );
  }
}
