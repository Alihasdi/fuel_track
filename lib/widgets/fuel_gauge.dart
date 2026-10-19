import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// The maroon "days left" gauge from the Home screen.
class FuelGauge extends StatelessWidget {
  final int daysLeft;
  final int totalDays;
  final String label;

  const FuelGauge({
    super.key,
    required this.daysLeft,
    required this.totalDays,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final progress = totalDays == 0 ? 0.0 : daysLeft / totalDays;

    return Container(
      width: 240,
      height: 240,
      decoration: BoxDecoration(
        color: AppColors.maroon,
        borderRadius: BorderRadius.circular(48),
        border: Border.all(color: const Color(0xFF3A3A3A), width: 2),
      ),
      child: CustomPaint(
        painter: _ArcPainter(progress.clamp(0.0, 1.0)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$daysLeft',
                style: const TextStyle(
                  fontSize: 64,
                  height: 1,
                  fontWeight: FontWeight.w700,
                  color: AppColors.onDark,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.onDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ArcPainter extends CustomPainter {
  final double progress;

  _ArcPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    const startAngle = math.pi * 0.75;
    const sweep = math.pi * 1.5;
    final rect = Rect.fromCircle(
      center: size.center(Offset.zero),
      radius: size.width * 0.36,
    );

    final track = Paint()
      ..color = Colors.white.withValues(alpha: 0.25)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16;
    final fill = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16;

    canvas.drawArc(rect, startAngle, sweep, false, track);
    canvas.drawArc(rect, startAngle, sweep * progress, false, fill);
  }

  @override
  bool shouldRepaint(_ArcPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
