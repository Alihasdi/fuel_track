import 'package:flutter/material.dart';

import '../models/refill.dart';
import '../theme/app_theme.dart';
import '../utils/formatters.dart';
import '../widgets/arrow_card.dart';
import 'refill_detail_screen.dart';
import 'statistics_screen.dart';

class HistoryScreen extends StatelessWidget {
  final List<Refill> refills;
  final String unit;

  const HistoryScreen({super.key, required this.refills, required this.unit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        title: const Text('History'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: refills.isEmpty
                ? const Center(child: Text('No refills yet'))
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                    itemCount: refills.length,
                    itemBuilder: (context, index) {
                      final refill = refills[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: ArrowCard(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => RefillDetailScreen(
                                refill: refill,
                                unit: unit,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.calendar_today_outlined,
                                  size: 30),
                              const SizedBox(width: 18),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      shortDate(refill.date),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      '${refill.liters} $unit',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              child: SizedBox(
                width: double.infinity,
                height: 64,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.plum,
                    foregroundColor: AppColors.onDark,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                      side: const BorderSide(color: Colors.black),
                    ),
                    textStyle: AppTheme.buttonText(24),
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          StatisticsScreen(refills: refills, unit: unit),
                    ),
                  ),
                  child: const Text('View Statistics'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
