import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Grey card with the maroon arrow tab on the right, used on the
/// History and Profile screens.
class ArrowCard extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final BorderRadius borderRadius;
  final bool showShadow;

  const ArrowCard({
    super.key,
    required this.child,
    required this.onTap,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    this.showShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: showShadow
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ]
            : null,
      ),
      child: Material(
        color: AppColors.card,
        borderRadius: borderRadius,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 18,
                    ),
                    child: child,
                  ),
                ),
                Container(
                  width: 64,
                  color: AppColors.maroon,
                  child: const Icon(
                    Icons.chevron_right,
                    color: AppColors.onDark,
                    size: 36,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
