# Widgetarian

[![Pub Version](https://img.shields.io/pub/v/widgetarian)](https://pub.dev/packages/widgetarian)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

**Widgetarian** is the official umbrella UI toolkit for Flutter, consolidating the best composable, reactive, and beautifully styled components under a single import.

## What's Included

Widgetarian re-exports and integrates the entire modular ecosystem:

| Package | Description |
|---|---|
| [`wx_text`](https://pub.dev/packages/wx_text) | Advanced text styling, gradients, outlines, filters, and variants |
| [`wx_text_animated`](https://pub.dev/packages/wx_text_animated) | Smooth animated typography transitions |
| [`wx_spoiler`](https://pub.dev/packages/wx_spoiler) | Collapsible text and blurred spoiler widgets |
| [`choice`](https://pub.dev/packages/choice) | Flexible inline and prompted single/multiple selection chips & sheets |
| [`wx_avatar`](https://pub.dev/packages/wx_avatar) | Customizable avatars with shapes, fallbacks, and badges |
| [`wx_badge`](https://pub.dev/packages/wx_badge) | Positioned notification and counter badges |
| [`wx_box`](https://pub.dev/packages/wx_box) | Highly configurable decorated container boxes |
| [`wx_tile`](https://pub.dev/packages/wx_tile) | Modular ListTile replacement with custom leading, trailing, and alignment |
| [`wx_divider`](https://pub.dev/packages/wx_divider) | Enhanced dividers with spacing, custom lines, and headers |
| [`wx_layout`](https://pub.dev/packages/wx_layout) | Layout utilities including `WxGap`, `WxBox`, and sheets |
| [`fancy_border`](https://pub.dev/packages/fancy_border) | Gradient, dotted, and dashed border decorators |
| [`marquee_transition`](https://pub.dev/packages/marquee_transition) | Smooth continuous text and widget marquee transitions |
| [`theme_patrol`](https://pub.dev/packages/theme_patrol) | Declarative theme mode manager and theme switcher |
| [`wheel_choice`](https://pub.dev/packages/wheel_choice) | iOS-style scrollable wheel pickers |
| [`disclosure`](https://pub.dev/packages/disclosure) | Accordion and collapsible disclosure panels |
| [`animated_checkmark`](https://pub.dev/packages/animated_checkmark) | Smooth drawn SVG-style checkmark animations |
| [`animated_repeatable`](https://pub.dev/packages/animated_repeatable) | Looping and pulsing animation wrappers |
| [`animated_switcher_transitions`](https://pub.dev/packages/animated_switcher_transitions) | Rich transition effects for AnimatedSwitcher |
| [`animated_transform`](https://pub.dev/packages/animated_transform) | Implicitly animated scale, rotate, and translate transforms |
| [`animated_icon_theme`](https://pub.dev/packages/animated_icon_theme) | Animated icon theme transitions |
| [`overlap_stack`](https://pub.dev/packages/overlap_stack) | Stacking overlapping avatar/card lists |
| [`chronograph`](https://pub.dev/packages/chronograph) | Precision stopwatch and timer utilities |
| [`lerp`](https://pub.dev/packages/lerp) | Linear interpolation primitives |
| [`wx_utils`](https://pub.dev/packages/wx_utils) | Color contrasting and common UI utilities |

## Installation

```yaml
dependencies:
  widgetarian: ^1.0.0
```

## Quick Start

Import everything with a single line:

```dart
import 'package:flutter/material.dart';
import 'package:widgetarian/widgetarian.dart';

class MyScreen extends StatelessWidget {
  const MyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: WxListTile(
          leading: const WxAvatar.circle(child: Text('W')),
          title: const WxText.titleMedium('Widgetarian App'),
          subtitle: const Text('All widgets under one clean namespace'),
          trailing: const WxBadge(
            content: Text('PRO'),
            child: Icon(Icons.star, color: Colors.amber),
          ),
        ),
      ),
    );
  }
}
```

## License

MIT © [davigmacode](https://github.com/davigmacode)
