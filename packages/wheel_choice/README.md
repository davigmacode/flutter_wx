[![Pub Version](https://img.shields.io/pub/v/wheel_choice)](https://pub.dev/packages/wheel_choice) [![Pub Points](https://img.shields.io/pub/points/wheel_choice)](https://pub.dev/packages/wheel_choice/score) [![CI](https://github.com/davigmacode/flutter_wheel_choice/actions/workflows/ci.yml/badge.svg)](https://github.com/davigmacode/flutter_wheel_choice/actions/workflows/ci.yml) [![Coverage](https://img.shields.io/badge/coverage-91%25-brightgreen.svg)](https://github.com/davigmacode/flutter_wheel_choice) [![Tests](https://img.shields.io/badge/tests-40%20passed-success.svg)](https://github.com/davigmacode/flutter_wheel_choice) ![GitHub](https://img.shields.io/github/license/davigmacode/flutter_wheel_choice) [![GitHub](https://badgen.net/badge/icon/buymeacoffee?icon=buymeacoffee&color=yellow&label)](https://www.buymeacoffee.com/davigmacode) [![GitHub](https://badgen.net/badge/icon/ko-fi?icon=kofi&color=red&label)](https://ko-fi.com/davigmacode)

Wheel-shaped picker widget for Flutter. Scroll and select items with customizable header, overlays, magnifier and 3D effects, disabled items, looping, themes, and custom item builders.

Demo: https://davigmacode.github.io/flutter_wheel_choice

## Layout Overview

```text
┌─────────────────────────────────────────┐  ▲
│               WheelHeader               │  │ header.extent
├─────────────────────────────────────────┤  ▼
│               Item (Top)                │  ▲
│   ┌─────────────────────────────────┐   │  │
│   │      WheelOverlay (Active)      │   │  │ viewportHeight = itemExtent * itemVisible
│   └─────────────────────────────────┘   │  │
│              Item (Bottom)              │  │
└─────────────────────────────────────────┘  ▼
```

## Features

- Customizable wheel/slot-style picker (`WheelChoice<T>`)
- Optional header (`WheelHeader`) aligned with the wheel viewport
- Overlays to highlight selection (outlined or filled via `WheelOverlay`)
- 3D look and magnifier (`WheelEffect`) with tunable perspective and diameter
- Subtree theming via `WheelChoiceTheme`
- Isolated reactive item rendering (no parent rebuild needed on selection changes)
- Item builder and label resolver (`WheelItem.delegate`, `itemLabel`)
- Disable items and optionally loop the list (`itemDisabled`, `loop`)
- Programmatic control (`WheelController.next`, `.previous`, `.setValue`, `.animateToIndex`)
- Form integration: ready-to-use FormField (`WheelChoiceFormField<T>`)
- Reactive listeners: `valueListenable`, `indexListenable`
- Dual callbacks: `onChanged` (value) and `onIndexChanged` (index)
- Custom scroll `physics` and `clipBehavior`
- Adaptive height with `expanded` and `itemVisible`

## Installation

```sh
flutter pub add wheel_choice
```

Import:

```dart
import 'package:wheel_choice/wheel_choice.dart';
```

## Quick start

```dart
final picker = WheelChoice<String>(
  options: const ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'],
  value: 'Wed',
  onChanged: (v) => debugPrint('Selected: $v'),
  onIndexChanged: (i) => debugPrint('Index: $i'),
  itemVisible: 5, // should be odd; auto-normalized
  header: const WheelHeader(child: Text('Day')),
  overlay: WheelOverlay.outlined(inset: 12),
  effect: const WheelEffect(useMagnifier: true, magnification: 1.1),
);
```

### Theming with `WheelChoiceTheme`

Configure shared styles across multiple wheel pickers without repeating properties:

```dart
WheelChoiceTheme(
  data: WheelChoiceThemeData(
    itemExtent: 44,
    itemVisible: 5,
    overlay: WheelOverlay.outlined(inset: 8),
    haptics: true,
  ),
  child: Row(
    children: [
      Expanded(child: WheelChoice<int>(options: hours)),
      Expanded(child: WheelChoice<int>(options: minutes)),
    ],
  ),
);
```

### Horizontal Orientation

Change scrolling orientation to horizontal using `scrollDirection: Axis.horizontal`:

```dart
WheelChoice<int>(
  options: const [1, 2, 3, 4, 5],
  value: 3,
  scrollDirection: Axis.horizontal,
  itemExtent: 70, // represents item width
  itemVisible: 5,
  overlay: WheelOverlay.outlined(axis: Axis.horizontal),
)
```

### Handling Null Values (Explicit Null Option)

To represent an "unselected" or "none" state in the wheel drum, include `null` in the options list:

```dart
WheelChoice<String?>(
  options: const [null, 'Apple', 'Banana', 'Cherry'],
  value: _selectedFruit, // null or item
  itemLabel: (v) => v ?? '— None —',
  onChanged: (v) => setState(() => _selectedFruit = v),
)
```

### Form integration with `WheelChoiceFormField`

Integrate seamlessly with Flutter's `Form`, validation, and `InputDecoration`:

```dart
WheelChoiceFormField<String>(
  options: const ['Red', 'Green', 'Blue'],
  initialValue: 'Red',
  decoration: const InputDecoration(
    labelText: 'Favorite Color',
    border: OutlineInputBorder(),
  ),
  validator: (val) => val == null ? 'Please select a color' : null,
  onSaved: (val) => debugPrint('Saved: $val'),
)
```

### Custom Header with `WheelHeader`

Add titles, icons, or status badges directly above the picker viewport:

```dart
WheelChoice<String>(
  options: const ['USD', 'EUR', 'GBP', 'JPY', 'IDR'],
  value: 'USD',
  header: WheelHeader(
    extent: 44,
    decoration: BoxDecoration(
      color: Colors.blue.withValues(alpha: 0.1),
      borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
    ),
    child: const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.currency_exchange, size: 16),
        SizedBox(width: 8),
        Text('Currency', style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    ),
  ),
  overlay: WheelOverlay.outlined(inset: 16),
)
```

### Programmatic control

Use `WheelController` to change selection by value or index and step with `next()` and `previous()`:

```dart
final days = const ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];
final controller = WheelController<String>(
  options: days,
  value: 'Wed',
  onChanged: (v) => debugPrint('Selected: $v'),
);

WheelChoice<String>.raw(controller: controller);

// Step programmatically
if (controller.hasNext) {
  await controller.next();
}

// Programmatically select a value
await controller.setValue('Fri', animate: true);

// If your options list changes, update the controller too
controller.setOptions(const ['Tue', 'Wed', 'Thu']);
```

### Reactive listeners (no onChanged)

React to selection changes using `ValueListenableBuilder` without wiring `onChanged`:

```dart
final controller = WheelController<String>(options: days, value: 'Wed');

Column(
  children: [
    WheelChoice<String>.raw(controller: controller),
    const SizedBox(height: 8),
    ValueListenableBuilder<String?>(
      valueListenable: controller.valueListenable,
      builder: (context, v, _) => Text('Selected: ${v ?? '-'}'),
    ),
  ],
);
```

### Keyboard & haptics

Enable keyboard navigation (↑/↓, PgUp/PgDn, Home/End) and haptics:

```dart
WheelChoice<String>(
  options: days,
  value: 'Wed',
  keyboard: true, // focus the wheel to use keys
  haptics: true,  // selection click on scroll
)
```

Note (experimental):
- Keyboard and haptic feedback are experimental. APIs may evolve.
- Keyboard requires the wheel to be focused (click it or provide a FocusNode and request focus).
- Haptics are only felt on real devices; desktop/web/emulators typically do not vibrate.

## Cheat Sheet

| Property | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `options` | `List<T>?` | `null` | Selectable values |
| `value` | `T?` | `null` | Initial selected value (defaults to first item if not in list) |
| `onChanged` | `ValueChanged<T>?` | `null` | Invoked on value change |
| `onIndexChanged` | `ValueChanged<int>?` | `null` | Invoked on index change |
| `itemVisible` | `int?` | `5` | Visible rows in viewport (auto-normalized to odd number) |
| `itemExtent` | `double?` | `40.0` | Height of each item row |
| `loop` | `bool?` | `false` | Enables wrap-around list scrolling |
| `expanded` | `bool?` | `false` | Adapts height to parent constraints |
| `header` | `WheelHeader?` | `null` | Header row above viewport |
| `overlay` | `WidgetBuilder?` | `null` | Selection highlight overlay |
| `effect` | `WheelEffect?` | `const WheelEffect()` | 3D curvature, magnifier & perspective |
| `keyboard` | `bool?` | `false` | Enables arrow keys, page up/down, home/end |
| `haptics` | `bool?` | `false` | Selection click haptic feedback on scroll |
| `scrollDirection` | `Axis` | `Axis.vertical` | Scrolling orientation (`Axis.vertical` or `Axis.horizontal`) |

## Best Practices & Performance Guide

### 1. Prefer Reactive Listeners over Parent `setState()`
If your widget tree contains heavy forms, multiple cards, or complex layouts, avoid calling `setState()` inside `onChanged` or `onIndexChanged`. Calling `setState()` in the parent forces the entire page to rebuild on every scroll tick.

Instead, use `WheelController` and listen directly via `ValueListenableBuilder`:

```dart
// ❌ Avoid: Triggers full parent rebuild on every scroll tick
WheelChoice<String>(
  options: items,
  onChanged: (v) => setState(() => _selected = v),
)

// ✅ Recommended: Zero parent rebuilds, butter-smooth 60/120 FPS dragging
WheelChoice<String>.raw(
  controller: _controller,
)

// Only the small output widget rebuilds:
ValueListenableBuilder<String?>(
  valueListenable: _controller.valueListenable,
  builder: (context, val, _) => Text('Selected: ${val ?? '-'}'),
)
```

### 2. Keep Custom `itemBuilder` Lightweight
- Render flat, lightweight rows or use `WheelItem.delegate()`.
- Avoid deep widget hierarchies, complex decorations/box shadows, or expensive operations (e.g. searching collections or parsing dates) directly inside the item builder.

### 3. Use Magnifier Judiciously
- `WheelEffect(useMagnifier: true)` applies optical magnification with an extra raster layer in Flutter's rendering pipeline.
- For maximum scroll performance or modern minimalist layouts, consider `const WheelEffect.flat()` or omit `useMagnifier`.

### 4. Finite vs. Loop Mode Sizing
- **Finite mode (`loop: false`)**: Children are lazily instantiated on demand (`ListWheelChildBuilderDelegate`). Ideal for datasets of any size.
- **Loop mode (`loop: true`)**: All children are instantiated upfront (`ListWheelChildLoopingListDelegate`). Best suited for circular datasets under $\le 100$ items (e.g. hours, minutes, months).

### 5. Group Related Pickers with `WheelChoiceTheme`
Instead of duplicating `itemExtent`, `overlay`, `effect`, and `haptics` across multiple side-by-side pickers, wrap them in a single `WheelChoiceTheme`. This centralizes configuration and reduces widget tree overhead.

### 6. Handling Null & Unselected States
Physical cylindrical wheels must always land on a physical slot. To handle optional, none, or unselected states:
- **Explicit Null Slot (Recommended)**: Use `WheelChoice<T?>` with `[null, ...items]` and format the unselected row with `itemLabel: (v) => v ?? '— None —'`. This provides clear visual feedback to the user.
- **Mandatory Form Selection**: Use `WheelChoiceFormField<T>` with `initialValue: null`. The form field stays `null` until the user actively interacts with the wheel. A validator `(v) => v == null ? 'Required' : null` will properly reject submissions if the picker is left untouched.
- **Empty Options**: If options are loaded asynchronously from an API and initially empty, `WheelController.selectedIndex` safely returns `-1`, and `hasPrevious` and `hasNext` return `false`.


## Examples

This package ships with a runnable example that demonstrates:

- Month + day pickers side-by-side (month loops)
- Time picker: hour, minute, AM/PM in a row, with programmatic controls
- Custom item builder with icons and expanded layout

Run locally:

```sh
cd example
flutter run
```

On desktop/web, enable mouse-drag scrolling by setting a `ScrollBehavior`:

```dart
MaterialApp(
  scrollBehavior: const MaterialScrollBehavior().copyWith(
    dragDevices: {
      PointerDeviceKind.touch,
      PointerDeviceKind.mouse,
      PointerDeviceKind.stylus,
      PointerDeviceKind.trackpad,
    },
  ),
  // ...
)
```

## API Reference

See full docs on pub.dev: https://pub.dev/documentation/wheel_choice/latest/

Key exports:

- `WheelChoice<T>` — the main widget
- `WheelChoiceFormField<T>` — form field integration with validation and decoration
- `WheelChoiceTheme` & `WheelChoiceThemeData` — subtree theming
- `WheelController<T>` — programmatic controller with `.next()` and `.previous()`
- `WheelHeader` — header above the viewport
- `WheelOverlay` — selection overlays (outlined/filled)
- `WheelEffect` — magnifier, perspective, diameter, opacity, squeeze
- `WheelItem.delegate` — default item renderer

## Changelog

See [CHANGELOG.md](CHANGELOG.md).

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Sponsoring

<a href="https://www.buymeacoffee.com/davigmacode" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" height="45"></a>
<a href="https://ko-fi.com/davigmacode" target="_blank"><img src="https://storage.ko-fi.com/cdn/brandasset/kofi_s_tag_white.png" alt="Ko-Fi" height="45"></a>

If this package or any other package I created is helping you, please consider to sponsor me so that I can take time to read the issues, fix bugs, merge pull requests and add features to these packages.
