import 'package:intl/intl.dart';

/// "Sunday, August 16 2026"
String longDate(DateTime date) => DateFormat('EEEE, MMMM d y').format(date);

/// "Sunday, Aug 10 2026"
String shortDate(DateTime date) => DateFormat('EEEE, MMM d y').format(date);

/// "Rp 45.000"
String rupiah(int amount) =>
    NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0)
        .format(amount);
