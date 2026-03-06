import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/routes/app_router.dart';
import 'widgets/register_form_widget.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24.w),
            child: Column(children: [
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF6C63FF).withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.person_add_outlined,
                    color: const Color(0xFF6C63FF), size: 48.sp),
              ),
              SizedBox(height: 24.h),
              Text('Create Account',
                  style: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1A1A2E))),
              SizedBox(height: 8.h),
              Text('Sign up to get started',
                  style: TextStyle(color: Colors.grey[600], fontSize: 15.sp)),
              SizedBox(height: 32.h),
              const RegisterFormWidget(),
              SizedBox(height: 20.h),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('Already have an account? ',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14.sp)),
                GestureDetector(
                  onTap: () =>
                      Navigator.pushReplacementNamed(context, AppRouter.login),
                  child: Text('Sign In',
                      style: TextStyle(
                          color: const Color(0xFF6C63FF),
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp)),
                ),
              ]),
            ]),
          ),
        ),
      ),
    );
  }
}
