[![Pub Version](https://img.shields.io/pub/v/chronograph)](https://pub.dev/packages/chronograph) ![GitHub](https://img.shields.io/github/license/davigmacode/flutter_chronograph) [![GitHub](https://badgen.net/badge/icon/buymeacoffee?icon=buymeacoffee&color=yellow&label)](https://www.buymeacoffee.com/davigmacode) [![GitHub](https://badgen.net/badge/icon/ko-fi?icon=kofi&color=red&label)](https://ko-fi.com/davigmacode)

Chronograph is a lightweight, reactive engine for stopwatch and countdown use‑cases in Flutter. It exposes a simple ValueListenable<Chrono> (ChronoGraph) that widgets can listen to, with factory constructors for a classic stopwatch, a fixed‑duration timer, and a countdown to a specific DateTime. A tiny ChronoView widget makes UI binding trivial while keeping you in full control of the rendering.

## Features

- Reactive engine: expose `ValueListenable<Chrono>` for easy UI updates
- Three modes: `stopwatch`, `timer(duration)`, `countdown(date)`
- Tiny view helper: `ChronoView` wraps `ValueListenableBuilder<Chrono>`
- Configurable tick `interval` and display `level` (days/hours/minutes/seconds)
- Optional `autostart` and `onCompleted` callback for countdowns/timers
- Immutable `Chrono` value with padded strings and total time helpers
- Pure Dart implementation — no platform channels, test‑friendly

## Usage

For a complete usage, please see the [example](https://davigmacode.github.io/flutter_chronograph).

To read more about classes and other references used by `chronograph`, see the [API Reference](https://pub.dev/documentation/chronograph/latest/).

### Stopwatch (count up)

```dart
final graph = ChronoGraph.stopwatch(
  level: ChronoLevel.seconds,
  interval: const Duration(seconds: 1),
  autostart: false, // call start() manually
);

// Control
graph.start();
graph.pause();
graph.reset();

// Build UI
ChronoView(
  graph: graph,
  builder: (context, info, _) => Text(
    '${info.paddedMinutes}:${info.paddedSeconds}',
  ),
);
```

### Timer (fixed duration)

```dart
final timer = ChronoGraph.timer(
  duration: const Duration(seconds: 10),
  autostart: true,
  onCompleted: () => debugPrint('Timer completed'),
);

ChronoView(
  graph: timer,
  builder: (context, info, _) => Text(
    '${info.paddedMinutes}:${info.paddedSeconds}',
  ),
);
```

### Countdown to a DateTime

```dart
final countdown = ChronoGraph.countdown(
  date: DateTime(2025, 1, 1), // target date
  autostart: true,
  onCompleted: () => debugPrint('Happy New Year!'),
);

ChronoView(
  graph: countdown,
  builder: (context, info, _) => Text(
    '${info.paddedMinutes}:${info.paddedSeconds}',
  ),
);
```

## Sponsoring

<a href="https://www.buymeacoffee.com/davigmacode" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" height="45"></a>
<a href="https://ko-fi.com/davigmacode" target="_blank"><img src="https://storage.ko-fi.com/cdn/brandasset/kofi_s_tag_white.png" alt="Ko-Fi" height="45"></a>

If this package or any other package I created is helping you, please consider to sponsor me so that I can take time to read the issues, fix bugs, merge pull requests and add features to these packages.
