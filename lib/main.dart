import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'myapp.dart';

void main() {
  runApp(ScreenUtilInit(
    designSize: const Size(428, 926),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (_, child) {
      return const MyApp();
    },
  ));
}
