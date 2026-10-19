import 'package:flutter/material.dart';

import '../models/refill.dart';
import '../theme/app_theme.dart';
import '../utils/formatters.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/fuel_gauge.dart';
import 'add_refill_screen.dart';
import 'history_screen.dart';
import 'prediction_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserSettings _settings = const UserSettings(
    name: 'Raka',
    email: 'raka@gmail.com',
    vehicle: 'Motorcycle',
    refillPeriodDays: 21,
    reminderDays: 2,
    unit: 'Liter (L)',
  );

  // Sample data so the app has something to show on first launch.
  final List<Refill> _refills = [
    Refill(
      date: _daysAgo(11),
      liters: 3.5,
      price: 35000,
      station: 'Pertamina Jl. Sudirman',
    ),
    Refill(
      date: _daysAgo(32),
      liters: 4,
      price: 40000,
      station: 'Shell Kemang',
    ),
    Refill(
      date: _daysAgo(53),
      liters: 3,
      price: 30000,
      station: 'Pertamina Jl. Sudirman',
    ),
    Refill(
      date: _daysAgo(75),
      liters: 4.5,
      price: 45000,
      station: 'BP Senayan',
    ),
  ];

  static DateTime _daysAgo(int days) {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day - days);
  }

  Refill get _lastRefill => _refills.first;

  DateTime get _nextRefill =>
      _lastRefill.date.add(Duration(days: _settings.refillPeriodDays));

  int get _daysLeft {
    final today = _daysAgo(0);
    final left = _nextRefill.difference(today).inDays;
    return left < 0 ? 0 : left;
  }

  Future<void> _openAddRefill() async {
    final Refill? newRefill = await Navigator.push<Refill>(
      context,
      MaterialPageRoute(
        builder: (_) => AddRefillScreen(unit: _settings.unitShort),
      ),
    );

    if (newRefill != null) {
      setState(() {
        _refills.insert(0, newRefill);
        _refills.sort((a, b) => b.date.compareTo(a.date));
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Refill of ${newRefill.liters} ${_settings.unitShort} saved',
          ),
        ),
      );
    }
  }

  void _openHistory() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => HistoryScreen(
          refills: _refills,
          unit: _settings.unitShort,
        ),
      ),
    );
  }

  Future<void> _openProfile() async {
    final UserSettings? updated = await Navigator.push<UserSettings>(
      context,
      MaterialPageRoute(builder: (_) => ProfileScreen(settings: _settings)),
    );
    if (updated != null) {
      setState(() => _settings = updated);
    }
  }

  void _openPrediction() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PredictionScreen(
          refills: _refills,
          settings: _settings,
        ),
      ),
    );
  }

  void _showMenu() {
    showModalBottomSheet(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.receipt_long_outlined),
              title: const Text('History'),
              onTap: () {
                Navigator.pop(sheetContext);
                _openHistory();
              },
            ),
            ListTile(
              leading: const Icon(Icons.show_chart),
              title: const Text('Prediction'),
              onTap: () {
                Navigator.pop(sheetContext);
                _openPrediction();
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(sheetContext);
                _openProfile();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final daysLeft = _daysLeft;

    // Warn the user when the tank is close to empty.
    String gaugeLabel;
    if (daysLeft == 0) {
      gaugeLabel = 'Refill today!';
    } else if (daysLeft <= _settings.reminderDays) {
      gaugeLabel = 'Refill soon';
    } else {
      gaugeLabel = daysLeft == 1 ? 'Day left' : 'Days left';
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        title: const Text('Fuel Track'),
        leading: IconButton(
          icon: const Icon(Icons.search, size: 30),
          onPressed: _openHistory,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, size: 30),
            onPressed: _showMenu,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
        child: Column(
          children: [
            FuelGauge(
              daysLeft: daysLeft,
              totalDays: _settings.refillPeriodDays,
              label: gaugeLabel,
            ),
            const SizedBox(height: 28),
            _RefillInfoCard(
              lastRefill: longDate(_lastRefill.date),
              nextRefill: longDate(_nextRefill),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 64,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.plum,
                  foregroundColor: AppColors.onDark,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  textStyle: AppTheme.buttonText(26),
                ),
                onPressed: _openAddRefill,
                child: const Text('+ Add refill'),
              ),
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              height: 64,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.text,
                  side: const BorderSide(color: AppColors.text),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  textStyle: AppTheme.buttonText(26),
                ),
                onPressed: _openPrediction,
                child: const Text('View Prediction'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: FuelBottomNav(
        onHistory: _openHistory,
        onProfile: _openProfile,
      ),
    );
  }
}

class _RefillInfoCard extends StatelessWidget {
  final String lastRefill;
  final String nextRefill;

  const _RefillInfoCard({required this.lastRefill, required this.nextRefill});

  @override
  Widget build(BuildContext context) {
    const titleStyle = TextStyle(fontSize: 22, fontWeight: FontWeight.w700);
    const valueStyle = TextStyle(fontSize: 17);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Last refill', style: titleStyle),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(lastRefill, style: valueStyle),
          ),
          const SizedBox(height: 20),
          const Text('Estimated next refill', style: titleStyle),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(nextRefill, style: valueStyle),
          ),
        ],
      ),
    );
  }
}
