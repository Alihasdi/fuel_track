# Fuel Track

A Flutter app that tracks fuel (bensin) refills and estimates when the next refill is due.
Built from our Fuel Track UI/UX design (Home, History, Profile).

## Screens (`lib/screens/`)

| Screen | What it does |
| --- | --- |
| `home_screen.dart` | Days-left gauge, last and next refill, buttons to add a refill or see the prediction |
| `add_refill_screen.dart` | Form with TextFields and controllers; empty input shows a SnackBar |
| `history_screen.dart` | `ListView.builder` of all refills; tap one to open its detail |
| `refill_detail_screen.dart` | Liters, price, price per liter and gas station of one refill |
| `statistics_screen.dart` | Total refills, total fuel, average and total spent |
| `prediction_screen.dart` | Average days between refills and the next 3 predicted dates |
| `profile_screen.dart` | Vehicle, refill period, reminder and unit settings |

Every screen is reachable from Home using `Navigator.push` and goes back with `Navigator.pop`.

## Run it

```bash
flutter pub get
flutter run
```

## Tests

```bash
flutter test
```
