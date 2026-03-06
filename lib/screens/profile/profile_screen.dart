import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import 'widgets/profile_content.dart';
import 'widgets/profile_not_logged_in.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: Text('Profile',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1A1A2E),
        scrolledUnderElevation: 0,
      ),
      body: Consumer<AuthProvider>(
        builder: (context, auth, child) {
          final user = auth.user;
          return user == null
              ? const ProfileNotLoggedIn()
              : ProfileContent(user: user);
        },
      ),
    );
  }
}
