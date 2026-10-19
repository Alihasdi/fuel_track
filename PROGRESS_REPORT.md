# Fuel Track – Progress Report

## Written update (paste into Google Classroom)

So far we finished the main part of our Fuel Track app in Flutter. It has 7 screens (Home, Add Refill, History, Refill Detail, Statistics, Prediction and Profile), and you can reach all of them from the Home screen. You can add a refill with the form, and if you leave it empty a SnackBar tells you to fill it in, then the new refill shows up in the History list. Right now we are working on saving the data on the phone, because when you close the app everything goes back to the sample data. What's blocking us is that saving data is still new to us, and we still need every member to push a commit from their own GitHub account.

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
