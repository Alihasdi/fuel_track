import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:fuel_track/screens/add_refill_screen.dart';

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  testWidgets('Empty refill form shows a SnackBar', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: AddRefillScreen(unit: 'L')),
    );

    await tester.tap(find.text('Save refill'));
    await tester.pump();

    expect(find.text('Please fill in the amount and the price'), findsOneWidget);
  });
}
