import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Maroon bottom bar with Home / History / Profile from the design.
class FuelBottomNav extends StatelessWidget {
  final VoidCallback onHistory;
  final VoidCallback onProfile;

  const FuelBottomNav({
    super.key,
    required this.onHistory,
    required this.onProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.maroon,
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 84,
          child: Row(
            children: [
              _NavItem(icon: Icons.home_rounded, label: 'Home', onTap: () {}),
              _NavItem(
                icon: Icons.receipt_long_outlined,
                label: 'History',
                onTap: onHistory,
              ),
              _NavItem(
                icon: Icons.person_outline,
                label: 'Profile',
                onTap: onProfile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.onDark, size: 32),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.onDark,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
