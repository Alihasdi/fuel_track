import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fuel_track/screens/home_screen.dart';

void main() {
  Future<void> openHome(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.6;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));
    await tester.pumpAndSettle();
  }

  testWidgets('Adding a refill shows it in History', (tester) async {
    await openHome(tester);

    await tester.tap(find.text('+ Add refill'));
    await tester.pumpAndSettle();
    expect(find.text('Add Refill'), findsOneWidget);

    await tester.enterText(find.byType(TextField).at(0), '2.5');
    await tester.enterText(find.byType(TextField).at(1), '25000');
    await tester.tap(find.text('Save refill'));
    await tester.pumpAndSettle();

    expect(find.text('Fuel Track'), findsOneWidget);
    expect(find.text('Refill of 2.5 L saved'), findsOneWidget);

    await tester.tap(find.text('History'));
    await tester.pumpAndSettle();
    expect(find.text('2.5 L'), findsOneWidget);

    await tester.tap(find.text('2.5 L'));
    await tester.pumpAndSettle();
    expect(find.text('Refill Detail'), findsOneWidget);
    expect(find.text('Unknown station'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back_ios_new));
    await tester.pumpAndSettle();
    await tester.tap(find.text('View Statistics'));
    await tester.pumpAndSettle();
    expect(find.text('5'), findsOneWidget);
  });

  testWidgets('Profile setting change updates Home', (tester) async {
    await openHome(tester);
    expect(find.text('10'), findsOneWidget);

    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Every 3 weeks'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Every 4 weeks'));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.arrow_back_ios_new));
    await tester.pumpAndSettle();
    expect(find.text('17'), findsOneWidget);

    await tester.tap(find.text('View Prediction'));
    await tester.pumpAndSettle();
    expect(find.text('Next refills'), findsOneWidget);
  });
}
