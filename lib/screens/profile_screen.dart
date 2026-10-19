import 'package:flutter/material.dart';

import '../models/refill.dart';
import '../theme/app_theme.dart';
import '../widgets/arrow_card.dart';

class ProfileScreen extends StatefulWidget {
  final UserSettings settings;

  const ProfileScreen({super.key, required this.settings});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserSettings _settings = widget.settings;

  static const _vehicles = ['Motorcycle', 'Car'];
  static const _periods = [7, 14, 21, 28];
  static const _reminders = [1, 2, 3];
  static const _units = ['Liter (L)', 'Gallon (gal)'];

  /// Go back to Home and hand the (maybe changed) settings back.
  void _close() => Navigator.pop(context, _settings);

  Future<void> _choose<T>({
    required String title,
    required List<T> options,
    required T current,
    required String Function(T) labelOf,
    required UserSettings Function(T) apply,
  }) async {
    final T? picked = await showModalBottomSheet<T>(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            for (final option in options)
              ListTile(
                title: Text(labelOf(option)),
                trailing: option == current
                    ? const Icon(Icons.check, color: AppColors.maroon)
                    : null,
                onTap: () => Navigator.pop(sheetContext, option),
              ),
          ],
        ),
      ),
    );

    if (picked != null) {
      setState(() => _settings = apply(picked));
    }
  }

  String _periodLabel(int days) {
    if (days % 7 == 0) {
      final weeks = days ~/ 7;
      return weeks == 1 ? 'Every week' : 'Every $weeks weeks';
    } else {
      return 'Every $days days';
    }
  }

  String _reminderLabel(int days) =>
      days == 1 ? '1 day before empty' : '$days days before empty';

  @override
  Widget build(BuildContext context) {
    return PopScope<UserSettings>(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) _close();
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 72,
          title: const Text('Profile'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: _close,
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            const SizedBox(height: 8),
            const Center(
              child: CircleAvatar(
                radius: 56,
                backgroundColor: AppColors.text,
                child: CircleAvatar(
                  radius: 53,
                  backgroundColor: AppColors.background,
                  child: Icon(
                    Icons.person_outline,
                    size: 72,
                    color: AppColors.text,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              _settings.name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
            ),
            Text(
              _settings.email,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            const Text(
              'Settings',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            _SettingTile(
              title: 'Vehicle',
              value: _settings.vehicle,
              onTap: () => _choose<String>(
                title: 'Vehicle',
                options: _vehicles,
                current: _settings.vehicle,
                labelOf: (v) => v,
                apply: (v) => _settings.copyWith(vehicle: v),
              ),
            ),
            _SettingTile(
              title: 'Average refill period',
              value: _periodLabel(_settings.refillPeriodDays),
              onTap: () => _choose<int>(
                title: 'Average refill period',
                options: _periods,
                current: _settings.refillPeriodDays,
                labelOf: _periodLabel,
                apply: (v) => _settings.copyWith(refillPeriodDays: v),
              ),
            ),
            _SettingTile(
              title: 'Reminder',
              value: _reminderLabel(_settings.reminderDays),
              onTap: () => _choose<int>(
                title: 'Reminder',
                options: _reminders,
                current: _settings.reminderDays,
                labelOf: _reminderLabel,
                apply: (v) => _settings.copyWith(reminderDays: v),
              ),
            ),
            _SettingTile(
              title: 'Unit',
              value: _settings.unit,
              onTap: () => _choose<String>(
                title: 'Unit',
                options: _units,
                current: _settings.unit,
                labelOf: (v) => v,
                apply: (v) => _settings.copyWith(unit: v),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
        bottomNavigationBar: Material(
          color: AppColors.plum,
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _FooterTile(
                  label: 'About',
                  onTap: () => showAboutDialog(
                    context: context,
                    applicationName: 'Fuel Track',
                    applicationVersion: '0.1.0',
                    children: const [
                      Text('Track your fuel refills and know when '
                          'to fill up again.'),
                    ],
                  ),
                ),
                _FooterTile(
                  label: 'Log out',
                  onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Log out is not available yet'),
                    ),
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

class _SettingTile extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback onTap;

  const _SettingTile({
    required this.title,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: ArrowCard(
        borderRadius: BorderRadius.circular(12),
        showShadow: false,
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(fontSize: 17)),
          ],
        ),
      ),
    );
  }
}

class _FooterTile extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _FooterTile({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 28, vertical: 4),
      title: Text(
        label,
        style: const TextStyle(
          color: AppColors.onDark,
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: AppColors.onDark,
        size: 36,
      ),
      onTap: onTap,
    );
  }
}
