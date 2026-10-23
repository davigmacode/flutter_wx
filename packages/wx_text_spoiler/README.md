# wx_text_spoiler

An expandable and collapsible spoiler / read-more text widget for Flutter, built on top of [`wx_text`](https://pub.dev/packages/wx_text).

## Features

- 📖 **Expandable & Collapsible**: Smooth cross-fade transition between collapsed and expanded states.
- 🎛️ **Reactive Controller**: Control expansion externally with `WxSpoilerController` (`expand()`, `collapse()`, `toggle()`).
- 🌲 **Inherited Notifier**: Access the nearest controller easily via `WxSpoilerProvider.of(context)`.
- 🎨 **Full Styling Freedom**: Inherits all typography shortcuts and styling from `WxText`.

## Installation

Add `wx_text_spoiler` to your `pubspec.yaml`:

```yaml
dependencies:
  wx_text_spoiler: ^1.0.0
```

## Usage

### Basic Usage

```dart
import 'package:flutter/material.dart';
import 'package:wx_text_spoiler/wx_text_spoiler.dart';

Widget build(BuildContext context) {
  return WxSpoilerText(
    'This is a long text that will be collapsed by default. '
    'Tap anywhere to expand and read the full content.',
    maxLines: 2,
    onExpanded: (expanded) {
      print('Expanded state: $expanded');
    },
  );
}
```

### External Controller

```dart
final controller = WxSpoilerController();

// Toggle programmatically
controller.toggle();

// Use in widget
WxSpoilerText(
  'Controlled spoiler text content...',
  controller: controller,
  maxLines: 1,
);
```

## License

MIT License © [davigmacode](https://github.com/davigmacode)
