import 'package:flutter/material.dart';

import '../models/refill.dart';
import '../theme/app_theme.dart';
import '../utils/formatters.dart';

class RefillDetailScreen extends StatelessWidget {
  final Refill refill;
  final String unit;

  const RefillDetailScreen({
    super.key,
    required this.refill,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    final pricePerUnit = (refill.price / refill.liters).round();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        title: const Text('Refill Detail'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.maroon,
              borderRadius: BorderRadius.circular(32),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.local_gas_station,
                  color: AppColors.onDark,
                  size: 56,
                ),
                const SizedBox(height: 12),
                Text(
                  '${refill.liters} $unit',
                  style: const TextStyle(
                    color: AppColors.onDark,
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  shortDate(refill.date),
                  style: const TextStyle(color: AppColors.onDark, fontSize: 18),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _DetailRow(label: 'Total price', value: rupiah(refill.price)),
          _DetailRow(label: 'Price per $unit', value: rupiah(pricePerUnit)),
          _DetailRow(label: 'Gas station', value: refill.station),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 17),
            ),
          ),
        ],
      ),
    );
  }
}
