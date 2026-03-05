import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../config/routes/app_router.dart';
import '../../../providers/auth_provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Drawer(
      backgroundColor: Colors.white,
      child: Column(children: [
        // Header
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 24,
            left: 20,
            right: 20,
            bottom: 24,
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
                radius: 32,
                backgroundColor: Colors.white.withValues(alpha: 0.2),
                child: Icon(
                  auth.isLoggedIn ? Icons.person : Icons.person_outline,
                  color: Colors.white,
                  size: 36,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                auth.isLoggedIn ? auth.user!.name : 'Guest',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (auth.isLoggedIn)
                Text(
                  auth.user!.email,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 13,
                  ),
                )
              else
                Text(
                  'Sign in to unlock features',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 13,
                  ),
                ),
            ],
          ),
        ),

        const SizedBox(height: 8),

        // Menu items
        _DrawerItem(
          icon: Icons.home_outlined,
          label: 'Home',
          onTap: () => Navigator.pop(context),
        ),
        _DrawerItem(
          icon: Icons.favorite_outline,
          label: 'Favorites',
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, AppRouter.favorites);
          },
        ),
        _DrawerItem(
          icon: Icons.settings_outlined,
          label: 'Settings',
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, AppRouter.settings);
          },
        ),

        const Spacer(),

        // Login/Logout
        const Divider(height: 1),
        _DrawerItem(
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
        const SizedBox(height: 16),
      ]),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final c = color ?? const Color(0xFF1A1A2E);
    return ListTile(
      leading: Icon(icon, color: c, size: 24),
      title: Text(label,
          style:
              TextStyle(color: c, fontSize: 15, fontWeight: FontWeight.w500)),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
    );
  }
}
