import 'package:flutter/material.dart';

import '../models/refill.dart';
import '../theme/app_theme.dart';
import '../utils/formatters.dart';

class StatisticsScreen extends StatelessWidget {
  final List<Refill> refills;
  final String unit;

  const StatisticsScreen({super.key, required this.refills, required this.unit});

  @override
  Widget build(BuildContext context) {
    double totalLiters = 0;
    int totalSpent = 0;
    for (final refill in refills) {
      totalLiters += refill.liters;
      totalSpent += refill.price;
    }
    final average = refills.isEmpty ? 0.0 : totalLiters / refills.length;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        title: const Text('Statistics'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(20),
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: [
          _StatTile(
            icon: Icons.format_list_numbered,
            label: 'Refills',
            value: '${refills.length}',
          ),
          _StatTile(
            icon: Icons.local_gas_station,
            label: 'Total fuel',
            value: '${totalLiters.toStringAsFixed(1)} $unit',
          ),
          _StatTile(
            icon: Icons.water_drop_outlined,
            label: 'Average / refill',
            value: '${average.toStringAsFixed(1)} $unit',
          ),
          _StatTile(
            icon: Icons.payments_outlined,
            label: 'Total spent',
            value: rupiah(totalSpent),
          ),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.maroon,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.onDark, size: 34),
          const SizedBox(height: 10),
          FittedBox(
            child: Text(
              value,
              style: const TextStyle(
                color: AppColors.onDark,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.onDark, fontSize: 15),
          ),
        ],
      ),
    );
  }
}
