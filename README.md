# flutter_wx

The official monorepo for the `wx_*` ecosystem of Flutter UI component libraries by [davigmacode](https://github.com/davigmacode).

[![Test](https://github.com/davigmacode/flutter_wx/actions/workflows/test.yml/badge.svg)](https://github.com/davigmacode/flutter_wx/actions/workflows/test.yml)
[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](./LICENSE)

---

## 📦 Packages

| Package | Version | Description | Dependencies |
| :--- | :--- | :--- | :--- |
| [`animated_checkmark`](./packages/animated_checkmark) | [![pub package](https://img.shields.io/pub/v/animated_checkmark.svg)](https://pub.dev/packages/animated_checkmark) | Animated checkmark and cross icon with customizable stroke, size, and rounded caps. | Flutter SDK (Zero external dependencies) |
| [`animated_icon_theme`](./packages/animated_icon_theme) | [![pub package](https://img.shields.io/pub/v/animated_icon_theme.svg)](https://pub.dev/packages/animated_icon_theme) | Smooth animated icon theme data for transitioning icon properties implicitly. | Flutter SDK (Zero external dependencies) |
| [`animated_repeatable`](./packages/animated_repeatable) | [![pub package](https://img.shields.io/pub/v/animated_repeatable.svg)](https://pub.dev/packages/animated_repeatable) | Smooth repeatable, reversible, and triggered animations with customizable easing curves and transitions. | Flutter SDK (Zero external dependencies) |
| [`animated_switcher_transitions`](./packages/animated_switcher_transitions) | [![pub package](https://img.shields.io/pub/v/animated_switcher_transitions.svg)](https://pub.dev/packages/animated_switcher_transitions) | Collection of pre-built transition and layout builders for AnimatedSwitcher. | Flutter SDK (Zero external dependencies) |
| [`animated_transform`](./packages/animated_transform) | [![pub package](https://img.shields.io/pub/v/animated_transform.svg)](https://pub.dev/packages/animated_transform) | Dynamically scale, rotate, flip, and position widgets over time with animation capabilities. | Flutter SDK (Zero external dependencies) |
| [`chronograph`](./packages/chronograph) | [![pub package](https://img.shields.io/pub/v/chronograph.svg)](https://pub.dev/packages/chronograph) | Lightweight reactive stopwatch/countdown timers with ValueListenable and ChronoView. | Flutter SDK (Zero external dependencies) |
| [`disclosure`](./packages/disclosure) | [![pub package](https://img.shields.io/pub/v/disclosure.svg)](https://pub.dev/packages/disclosure) | Accessible controls and collapsible disclosure panels (like accordion panels). | Flutter SDK (Zero external dependencies) |
| [`lerp`](./packages/lerp) | [![pub package](https://img.shields.io/pub/v/lerp.svg)](https://pub.dev/packages/lerp) | Linearly interpolate between two numbers, booleans, or enums by an extrapolation factor. | Flutter SDK (Zero external dependencies) |
| [`overlap_stack`](./packages/overlap_stack) | [![pub package](https://img.shields.io/pub/v/overlap_stack.svg)](https://pub.dev/packages/overlap_stack) | Compact and visually interesting stack layout with configurable item overlapping. | Flutter SDK (Zero external dependencies) |
| [`theme_patrol`](./packages/theme_patrol) | [![pub package](https://img.shields.io/pub/v/theme_patrol.svg)](https://pub.dev/packages/theme_patrol) | Dynamic multiple theme manager with reactive mode and color control. | Flutter SDK (Zero external dependencies) |
| [`wheel_choice`](./packages/wheel_choice) | [![pub package](https://img.shields.io/pub/v/wheel_choice.svg)](https://pub.dev/packages/wheel_choice) | Wheel-shaped picker widget with 3D perspective, magnifier, looping, and custom builders. | Flutter SDK (Zero external dependencies) |
| [`wheel_choice_ext`](./packages/wheel_choice_ext) | [![pub package](https://img.shields.io/pub/v/wheel_choice_ext.svg)](https://pub.dev/packages/wheel_choice_ext) | Composite wheel-shaped date/time pickers with multi-column support, locale ordering, and form fields. | `wheel_choice`, `intl` |
| [`wx_box`](./packages/wx_box) | [![pub package](https://img.shields.io/pub/v/wx_box.svg)](https://pub.dev/packages/wx_box) | Flexible box and container widget with elevation, border effects, and animation support. | Flutter SDK (Zero external dependencies) |
| [`wx_divider`](./packages/wx_divider) | [![pub package](https://img.shields.io/pub/v/wx_divider.svg)](https://pub.dev/packages/wx_divider) | Highly customizable divider with configurable line pattern, count, gradient, and child widget. | Flutter SDK (Zero external dependencies) |
| [`wx_text`](./packages/wx_text) | [![pub package](https://img.shields.io/pub/v/wx_text.svg)](https://pub.dev/packages/wx_text) | Core Flutter text utility featuring Material 3 typography shortcuts, gradient shaders, outline strokes, and pattern filters. | Flutter SDK (Zero external dependencies) |
| [`wx_text_animated`](./packages/wx_text_animated) | [![pub package](https://img.shields.io/pub/v/wx_text_animated.svg)](https://pub.dev/packages/wx_text_animated) | Seamless typography animations (typing, shimmer, zoom, slide, shake, fade). | `wx_text`, `animated_repeatable` |
| [`wx_text_spoiler`](./packages/wx_text_spoiler) | [![pub package](https://img.shields.io/pub/v/wx_text_spoiler.svg)](https://pub.dev/packages/wx_text_spoiler) | Expandable and collapsible spoiler / read-more text widget with reactive controller. | `wx_text` |

---

## 🚀 Workspace Architecture

This monorepo is engineered for modern Dart development:
- **Dart 3.5+ Native Workspaces**: Unified dependency resolution with local path linking and a single shared `pubspec.lock`.
- **Melos**: Multi-package task orchestration, automated semantic versioning, and continuous delivery to pub.dev.
- **Modular Zero-Dependency Core**: Heavy features (animations, expandable widgets) are isolated into dedicated packages, keeping the core lightweight.
- **Showroom Application**: Cross-platform showcase and interactive gallery under [`example/`](./example).

---

## 🛠️ Development & Tooling

```bash
# Resolve dependencies across all workspace packages
dart pub get

# Run static analyzer across all packages
dart run melos run analyze

# Run unit and widget tests with coverage
dart run melos run test

# Format Dart codebase
dart run melos run format
```

---

## 📄 License

MIT License © [davigmacode](https://github.com/davigmacode)
