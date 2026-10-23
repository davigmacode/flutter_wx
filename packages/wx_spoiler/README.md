# wx_spoiler

An expandable and collapsible spoiler / read-more text and widget concealing component for Flutter, built on top of [`wx_text`](https://pub.dev/packages/wx_text).

## Features

- 🌫️ **Conceal Any Widget**: Wrap any widget (images, media, cards) with animated blur or custom placeholders with `WxSpoiler`.
- 📖 **Expandable & Collapsible Text**: Smooth cross-fade transition between collapsed and expanded text with `WxSpoilerText`.
- 🎛️ **Reactive Controller**: Control expansion externally with `WxSpoilerController` (`expand()`, `collapse()`, `toggle()`).
- 🌲 **Inherited Notifier**: Access the nearest controller easily via `WxSpoilerProvider.of(context)`.
- 🎨 **Full Styling Freedom**: Inherits all typography shortcuts and styling from `WxText`.

## Installation

Add `wx_spoiler` to your `pubspec.yaml`:

```yaml
dependencies:
  wx_spoiler: ^1.0.0
```

## Usage

### Widget & Image Spoiler

```dart
import 'package:flutter/material.dart';
import 'package:wx_spoiler/wx_spoiler.dart';

Widget build(BuildContext context) {
  return WxSpoiler(
    child: Image.network('https://example.com/secret.png'),
  );
}
```

### Collapsible Text Spoiler

```dart
import 'package:flutter/material.dart';
import 'package:wx_spoiler/wx_spoiler.dart';

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
WxSpoiler(
  controller: controller,
  child: const Text('Controlled spoiler content...'),
);
```

## License

MIT License © [davigmacode](https://github.com/davigmacode)
