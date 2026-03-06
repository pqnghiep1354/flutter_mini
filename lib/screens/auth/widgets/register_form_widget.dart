import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../config/routes/app_router.dart';
import '../../../providers/auth_provider.dart';
import 'auth_text_field.dart';

class RegisterFormWidget extends StatefulWidget {
  const RegisterFormWidget({super.key});

  @override
  State<RegisterFormWidget> createState() => _RegisterFormWidgetState();
}

class _RegisterFormWidgetState extends State<RegisterFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _phoneCtrl.dispose();
    _addressCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final auth = context.read<AuthProvider>();
    final success = await auth.register(
      name: _nameCtrl.text.trim(),
      email: _emailCtrl.text.trim(),
      password: _passwordCtrl.text,
      phone: _phoneCtrl.text.trim(),
      address: _addressCtrl.text.trim(),
    );
    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Registration successful! Please sign in.'),
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          backgroundColor: const Color(0xFF43E97B),
        ),
      );
      Navigator.pushReplacementNamed(context, AppRouter.login);
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
              controller: _nameCtrl,
              label: 'Full Name',
              icon: Icons.person_outline,
              validator: (v) =>
                  v == null || v.isEmpty ? 'Name is required' : null,
            ),
            SizedBox(height: 16.h),
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
              validator: (v) => v == null || v.length < 6
                  ? 'Password must be at least 6 chars'
                  : null,
            ),
            SizedBox(height: 16.h),
            AuthTextField(
              controller: _phoneCtrl,
              label: 'Phone (Optional)',
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 16.h),
            AuthTextField(
              controller: _addressCtrl,
              label: 'Address (Optional)',
              icon: Icons.location_on_outlined,
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
                        : Text('Sign Up',
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
