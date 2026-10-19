import 'package:flutter/material.dart';

import '../models/refill.dart';
import '../theme/app_theme.dart';
import '../utils/formatters.dart';

class PredictionScreen extends StatelessWidget {
  final List<Refill> refills;
  final UserSettings settings;

  const PredictionScreen({
    super.key,
    required this.refills,
    required this.settings,
  });

  /// Average number of days between the saved refills.
  /// Falls back to the period from the Profile settings
  /// when there is not enough history yet.
  int _averageGapDays() {
    if (refills.length < 2) {
      return settings.refillPeriodDays;
    }
    final newest = refills.first.date;
    final oldest = refills.last.date;
    return (newest.difference(oldest).inDays / (refills.length - 1)).round();
  }

  @override
  Widget build(BuildContext context) {
    final gap = _averageGapDays();
    final last = refills.first;
    final upcoming = List.generate(
      3,
      (i) => last.date.add(Duration(days: gap * (i + 1))),
    );

    String tip;
    if (gap < settings.refillPeriodDays) {
      tip = 'You refill more often than your usual '
          '${settings.refillPeriodDays}-day period.';
    } else if (gap > settings.refillPeriodDays) {
      tip = 'You refill less often than your usual '
          '${settings.refillPeriodDays}-day period.';
    } else {
      tip = 'Your refills match your usual period. Nice!';
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        title: const Text('Prediction'),
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
                const Text(
                  'You refill about every',
                  style: TextStyle(color: AppColors.onDark, fontSize: 18),
                ),
                const SizedBox(height: 6),
                Text(
                  '$gap days',
                  style: const TextStyle(
                    color: AppColors.onDark,
                    fontSize: 44,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  tip,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppColors.onDark, fontSize: 15),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Next refills',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          for (final date in upcoming)
            Card(
              color: AppColors.card,
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: ListTile(
                leading: const Icon(Icons.event_outlined),
                title: Text(
                  longDate(date),
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                subtitle: Text(
                  'Reminder ${settings.reminderDays} days before: '
                  '${shortDate(date.subtract(Duration(days: settings.reminderDays)))}',
                ),
              ),
            ),
        ],
      ),
    );
  }
}
