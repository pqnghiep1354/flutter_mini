import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import 'widgets/admin_form_widget.dart';
import 'widgets/admin_not_logged_in_view.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: Text('Tạo bài viết',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1A1A2E),
        scrolledUnderElevation: 0,
      ),
      body: Consumer<AuthProvider>(
        builder: (context, auth, child) {
          if (!auth.isLoggedIn) return const AdminNotLoggedInView();
          return const AdminFormWidget();
        },
      ),
    );
  }
}
