# Fuel Track – Progress Report

## Written update (paste into Google Classroom)

We finished the main Flutter app for Fuel Track: Home, Add Refill, History, Refill Detail, Statistics, Prediction and Profile, each in its own file in `lib/screens/` and all reachable from Home with `Navigator.push` and `Navigator.pop`. The Add Refill form uses TextFields with controllers that are disposed, shows a SnackBar when input is empty, and new refills appear in the History list built with `ListView.builder`. Right now we are working on saving refills on the device so the data stays after the app is closed, and on real reminder notifications. Our blocker is that the data still resets on restart, and we still need to set up the shared GitHub repo so every member can commit from their own account.

## Checklist against the assignment

| Section | Requirement | Where in the code |
| --- | --- | --- |
| A | Created with `flutter create`, runs with `flutter run` | whole project |
| B | `MaterialApp` + `Scaffold`, one theme | `lib/main.dart`, `lib/theme/app_theme.dart` |
| B | 2+ screens in `lib/screens/`, push/pop, all reachable from Home | 7 screens, `home_screen.dart` |
| C | `TextField` + `TextEditingController`, `dispose()`, SnackBar on empty input | `add_refill_screen.dart` |
| D | `StatefulWidget` + `setState` | `home_screen.dart`, `profile_screen.dart`, `add_refill_screen.dart` |
| D | Data passed through constructor | `HistoryScreen(refills:)`, `RefillDetailScreen(refill:)`, `ProfileScreen(settings:)` |
| D | Real `if` / `else` decisions | gauge label in `home_screen.dart`, validation in `add_refill_screen.dart`, tip in `prediction_screen.dart` |
| E | `ListView.builder` with `itemCount` + `itemBuilder`, add item, tap opens detail | `history_screen.dart` |
| F | Shared GitHub repo, every member commits | **still to do – see below** |

## Still to do before submitting

1. Create one GitHub repo (for example `fuel-track`) and add every member, plus `Azmi1180` if it is private.
2. Push this project. Each member clones it, runs `git pull`, makes a small change on their own branch and commits with a clear message, for example "Added gas station field to refill detail".
3. Take the screenshots: the GitHub repo page (files + commit history), and each screen running from VS Code or Android Studio with the editor visible.
4. Submit in Google Classroom: repo link + all member names in the private comment, the screenshots, and the written update above.
