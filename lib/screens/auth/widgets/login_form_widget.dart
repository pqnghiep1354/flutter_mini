import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart';
import 'auth_text_field.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final auth = context.read<AuthProvider>();
    final success = await auth.login(
      _emailCtrl.text.trim(),
      _passwordCtrl.text,
    );
    if (success && mounted) {
      Navigator.pop(context);
    }
  }

  Future<void> _submitGoogle() async {
    final auth = context.read<AuthProvider>();
    final success = await auth.loginWithGoogle();
    if (success && mounted) {
      Navigator.pop(context);
    }
  }

  Future<void> _submitAnon() async {
    final auth = context.read<AuthProvider>();
    final success = await auth.loginAnonymously();
    if (success && mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: _formKey,
          child: Column(children: [
            AuthTextField(
              controller: _emailCtrl,
              label: 'Email',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              validator: (v) =>
                  v == null || v.isEmpty ? 'Email is required' : null,
            ),
            SizedBox(height: 16.h),
            AuthTextField(
              controller: _passwordCtrl,
              label: 'Password',
              icon: Icons.lock_outline,
              obscure: _obscure,
              suffix: IconButton(
                icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey, size: 22.sp),
                onPressed: () => setState(() => _obscure = !_obscure),
              ),
              validator: (v) =>
                  v == null || v.isEmpty ? 'Password is required' : null,
            ),
          ]),
        ),
        Consumer<AuthProvider>(
          builder: (context, auth, child) {
            return Column(
              children: [
                if (auth.error != null)
                  Container(
                    margin: EdgeInsets.only(top: 8.h),
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(children: [
                      Icon(Icons.error_outline, color: Colors.red, size: 20.sp),
                      SizedBox(width: 8.w),
                      Expanded(
                          child: Text(auth.error!,
                              style: TextStyle(
                                  color: Colors.red, fontSize: 13.sp))),
                    ]),
                  ),
                SizedBox(height: 24.h),
                SizedBox(
                  width: double.infinity,
                  height: 52.h,
                  child: ElevatedButton(
                    onPressed: auth.isLoading ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C63FF),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.r)),
                      elevation: 0,
                    ),
                    child: auth.isLoading
                        ? SizedBox(
                            width: 24.w,
                            height: 24.w,
                            child: const CircularProgressIndicator(
                                strokeWidth: 2.5, color: Colors.white))
                        : Text('Sign In',
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.w600)),
                  ),
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey[300])),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text('OR',
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500)),
                    ),
                    Expanded(child: Divider(color: Colors.grey[300])),
                  ],
                ),
                SizedBox(height: 16.h),
                SizedBox(
                  width: double.infinity,
                  height: 52.h,
                  child: OutlinedButton.icon(
                    onPressed: auth.isLoading ? null : _submitGoogle,
                    icon: Image.network(
                      'https://www.google.com/images/branding/googleg/1x/googleg_standard_color_128dp.png',
                      height: 24.h,
                    ),
                    label: Text('Sign in with Google',
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1A1A2E))),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.grey[300]!),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.r)),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                SizedBox(
                  width: double.infinity,
                  height: 52.h,
                  child: TextButton(
                    onPressed: auth.isLoading ? null : _submitAnon,
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.grey[700],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.r)),
                    ),
                    child: Text('Continue as Guest',
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
