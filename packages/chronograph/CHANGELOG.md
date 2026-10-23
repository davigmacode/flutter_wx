## 1.0.2
- Align unit folding semantics: fold larger units down to the selected `ChronoLevel` (e.g., minutes folds days+hours into minutes; seconds folds all units).
- Update `ChronoLevel` Dart doc to reflect the folding behavior.
- Add `ChronoMode { forward, reverse }` and expose `isForward`/`isReverse` helpers.
- Refactor `ChronoGraph` to use `ChronoMode` instead of duration-based detection.
- Remove future-date assert in `countdown`; past/now targets initialize at zero with `completed: true` (no autostart).
- Change default display `level` to `ChronoLevel.days`.
- Minor docs adjustments to reflect new behavior.
- Add callbacks to `ChronoGraph`: `onStart`, `onPause`, `onReset` (`ValueChanged<Chrono>`), and `onCompleted` (`VoidCallback`).
- Add `ChronoProvider` and `ChronoView.of`/`ChronoProvider.builder` for easy provisioning and consumption.

## 1.0.1
- Add comprehensive Dart doc across `lib/src` (classes, fields, methods).
- Expand README with features and usage examples.
- Clarify package description in `pubspec.yaml` (<=175 chars).
- Add example: countdown to a specific `DateTime` in demo app.
- Translate Indonesian comments to English.
- Improve Pub score: add topics/metadata, documentation, examples, and linting.

## 1.0.0
- Initial release of Chronograph.
- `ChronoGraph` engine with factories: `stopwatch`, `timer`, `countdown`.
- `Chrono` value model with padded/time-total helpers.
- `ChronoView` widget for easy `ValueListenable<Chrono>` binding.
- Example app demonstrating stopwatch and timer.
