import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../apps/routers/router_name.dart';
import '../../../utils/app_colors.dart';

class DiveInButton extends StatefulWidget {
  const DiveInButton({super.key});

  @override
  State<DiveInButton> createState() => _DiveInButtonState();
}

class _DiveInButtonState extends State<DiveInButton> {
  bool _loading = false;

  Future<void> _onTap() async {
    if (_loading) return;
    setState(() => _loading = true);

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int counter = prefs.getInt('userCounter') ?? 0;
    await prefs.setInt('userCounter', counter + 1);

    if (!mounted) return;
    Navigator.pushReplacementNamed(context, RouterName.root);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: _loading ? null : _onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          disabledBackgroundColor: AppColors.primaryDark,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 4,
          shadowColor: AppColors.primary.withOpacity(0.4),
        ),
        child: _loading
            ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5))
            : const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Dive In', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, letterSpacing: 0.5)),
                  SizedBox(width: 10),
                  Icon(Icons.arrow_forward_rounded, size: 20),
                ],
              ),
      ),
    );
  }
}
