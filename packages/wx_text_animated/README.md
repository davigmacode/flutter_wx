# wx_text_animated

Seamless repeatable and triggered typography animations for Flutter, built on top of [`wx_text`](https://pub.dev/packages/wx_text) and [`animated_repeatable`](https://pub.dev/packages/animated_repeatable).

## Features

- ✨ **Built-in Presets**:
  - `shimmer`: Linear gradient sweep across text
  - `typing`: Typewriter letter-by-letter reveal with customizable cursor trail
  - `zoom`: Pulsing scale animation
  - `slide`: Directional offset transitions
  - `shake`: Shake animations (e.g. error alerts)
  - `fade`: Opacity fading transitions
- ⚙️ **Fine-grained Controls**: Supports loop repeating, pausing, and accessibility `disableAnimations`.

## Installation

Add `wx_text_animated` to your `pubspec.yaml`:

```yaml
dependencies:
  wx_text_animated: ^1.0.0
```

## Usage

```dart
import 'package:flutter/material.dart';
import 'package:wx_text/wx_text.dart';
import 'package:wx_text_animated/wx_text_animated.dart';

Widget build(BuildContext context) {
  return Column(
    children: [
      // Shimmer effect
      WxAnimatedText(
        transition: WxAnimatedText.shimmer(
          colors: [Colors.purple, Colors.cyan, Colors.purple],
        ),
        child: const WxText.headlineMedium('Shimmer Headline'),
      ),

      // Typewriter effect
      WxAnimatedText(
        duration: const Duration(seconds: 2),
        transition: WxAnimatedText.typing(trails: '_'),
        child: const WxText.bodyLarge('Typing effect with blinking cursor...'),
      ),
    ],
  );
}
```

## License

MIT License © [davigmacode](https://github.com/davigmacode)
