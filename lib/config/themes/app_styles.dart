import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// AppStyles contains all shared reusable styles, decorations,
/// and theme constants to prevent code duplication across screens.
class AppStyles {
  /// Trang trí dùng chung cho các trường nhập liệu (TextField, TextFormField)
  static InputDecoration inputDecoration({
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      hintText: hint,
      labelText: hint,
      labelStyle: TextStyle(fontSize: 14.sp),
      hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14.sp),
      prefixIcon: Icon(icon, color: const Color(0xFF6C63FF), size: 22.sp),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: const BorderSide(color: Color(0xFF6C63FF), width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: const BorderSide(color: Colors.red, width: 1),
      ),
    );
  }
}
