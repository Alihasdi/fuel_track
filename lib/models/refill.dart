/// One fuel refill entered by the user.
class Refill {
  final DateTime date;
  final double liters;
  final int price;
  final String station;

  const Refill({
    required this.date,
    required this.liters,
    required this.price,
    required this.station,
  });
}

/// The user's settings shown on the Profile screen.
class UserSettings {
  final String name;
  final String email;
  final String vehicle;
  final int refillPeriodDays;
  final int reminderDays;
  final String unit;

  const UserSettings({
    required this.name,
    required this.email,
    required this.vehicle,
    required this.refillPeriodDays,
    required this.reminderDays,
    required this.unit,
  });

  UserSettings copyWith({
    String? vehicle,
    int? refillPeriodDays,
    int? reminderDays,
    String? unit,
  }) {
    return UserSettings(
      name: name,
      email: email,
      vehicle: vehicle ?? this.vehicle,
      refillPeriodDays: refillPeriodDays ?? this.refillPeriodDays,
      reminderDays: reminderDays ?? this.reminderDays,
      unit: unit ?? this.unit,
    );
  }

  /// Short unit label, for example "L" or "gal".
  String get unitShort => unit == 'Liter (L)' ? 'L' : 'gal';
}
