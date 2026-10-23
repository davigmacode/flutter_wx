# widget_driven

Reactive event-driven widgets that automatically adapt their appearance, builders, spinners, and animated transitions based on `WidgetEvents`.

Part of the [Widgetarian](https://github.com/davigmacode/flutter_wx) ecosystem.

[![Pub Version](https://img.shields.io/pub/v/widget_driven.svg)](https://pub.dev/packages/widget_driven)
[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](./LICENSE)

---

## Features

- **`DrivenChild`**: Declarative child widget swapping based on active events (`loading`, `disabled`, `error`, `pressed`, `hovered`).
- **`DrivenBuilder`**: Clean builder providing `(context, events, child)` directly from a `WidgetEventController`.
- **`DrivenSpinner`**: Event-driven circular progress indicator with themeable stroke, color, and size.
- **`DrivenSwitcher`**: Smooth `AnimatedSwitcher` that automatically animates between states as events change.

---

## Usage

```dart
import 'package:flutter/material.dart';
import 'package:widget_event/widget_event.dart';
import 'package:widget_driven/widget_driven.dart';

// 1. DrivenBuilder
DrivenBuilder(
  controller: eventController,
  builder: (context, events, child) {
    return Text(events.contains(WidgetEvent.hovered) ? 'Hovering!' : 'Idle');
  },
);

// 2. DrivenSwitcher
DrivenSwitcher(
  const Text('Submit'),
  atLoading: const DrivenSpinner(size: 16),
  atError: const Icon(Icons.error_outline),
);
```
