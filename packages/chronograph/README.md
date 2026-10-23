[![Pub Version](https://img.shields.io/pub/v/chronograph)](https://pub.dev/packages/chronograph) ![GitHub](https://img.shields.io/github/license/davigmacode/flutter_chronograph) [![GitHub](https://badgen.net/badge/icon/buymeacoffee?icon=buymeacoffee&color=yellow&label)](https://www.buymeacoffee.com/davigmacode) [![GitHub](https://badgen.net/badge/icon/ko-fi?icon=kofi&color=red&label)](https://ko-fi.com/davigmacode)

Chronograph is a lightweight, reactive engine for stopwatch and countdown use‑cases in Flutter. It exposes a simple ValueListenable<Chrono> (ChronoGraph) that widgets can listen to, with factory constructors for a classic stopwatch, a fixed‑duration timer, and a countdown to a specific DateTime. A tiny ChronoView widget makes UI binding trivial while keeping you in full control of the rendering.

## Features

- Reactive engine: expose `ValueListenable<Chrono>` for easy UI updates
- Three modes: `stopwatch`, `timer(duration)`, `countdown(date)`
- Tiny view helper: `ChronoView` wraps `ValueListenableBuilder<Chrono>`
- Provider helper: `ChronoProvider` manages lifetime and exposes a shared graph
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

### Using ChronoProvider and ChronoView.of

Wrap a subtree with `ChronoProvider` to manage a shared graph and dispose it automatically. Use a `Builder` (or a separate widget) so the `context` passed to `ChronoView.of` is below the provider.

```dart
return ChronoProvider(
  graph: ChronoGraph.stopwatch(level: ChronoLevel.seconds),
  child: Builder(
    builder: (context) => Column(
      children: [
        ChronoView.of(
          context,
          builder: (ctx, info, _) => Text('${info.paddedMinutes}:${info.paddedSeconds}'),
        ),
      ],
    ),
  ),
);
```

Alternatively, use the builder convenience:

```dart
ChronoProvider.builder(
  graph: ChronoGraph.timer(duration: const Duration(seconds: 10)),
  builder: (ctx, graph, _) => Column(
    children: [
      ChronoView(
        graph: graph,
        builder: (ctx, info, __) => Text(
          '${info.paddedMinutes}:${info.paddedSeconds}',
        ),
      ),
      Row(
        children: [
          TextButton(onPressed: graph.start, child: const Text('Start')),
          TextButton(onPressed: graph.pause, child: const Text('Pause')),
          TextButton(onPressed: graph.reset, child: const Text('Reset')),
        ],
      )
    ],
  ),
);
```

Note: `ChronoProvider` owns the provided graph by default and disposes it on unmount. To keep the graph alive (managed externally), pass `maintainLifetime: false`:

```dart
ChronoProvider(
  graph: externalGraph,
  maintainLifetime: false,
  child: Builder(
    builder: (context) => ChronoView.of(
      context,
      builder: (ctx, info, _) => Text(info.paddedSeconds),
    ),
  ),
)
```

### Callbacks on ChronoGraph

You can observe lifecycle events with callbacks:

```dart
final g1 = ChronoGraph.stopwatch(
  onStart: (c) => debugPrint('Started at ${c.inSeconds}s'),
  onPause: (c) => debugPrint('Paused at ${c.inSeconds}s'),
  onReset: (c) => debugPrint('Reset to ${c.inSeconds}s'),
);

final g2 = ChronoGraph.timer(
  duration: const Duration(seconds: 10),
  onStart: (c) => debugPrint('Timer start: ${c.inSeconds}s remaining'),
  onPause: (c) => debugPrint('Timer pause: ${c.inSeconds}s remaining'),
  onReset: (c) => debugPrint('Timer reset: ${c.inSeconds}s remaining'),
  onCompleted: () => debugPrint('Timer completed'),
);
```

## Sponsoring

<a href="https://www.buymeacoffee.com/davigmacode" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" height="45"></a>
<a href="https://ko-fi.com/davigmacode" target="_blank"><img src="https://storage.ko-fi.com/cdn/brandasset/kofi_s_tag_white.png" alt="Ko-Fi" height="45"></a>

If this package or any other package I created is helping you, please consider to sponsor me so that I can take time to read the issues, fix bugs, merge pull requests and add features to these packages.
