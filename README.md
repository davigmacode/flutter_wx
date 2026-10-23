# flutter_wx

The official monorepo for the `wx_*` ecosystem of Flutter UI component libraries by [davigmacode](https://github.com/davigmacode).

[![Test](https://github.com/davigmacode/flutter_wx/actions/workflows/test.yml/badge.svg)](https://github.com/davigmacode/flutter_wx/actions/workflows/test.yml)
[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](./LICENSE)

---

## 📦 Packages

| Package | Version | Description | Dependencies |
| :--- | :--- | :--- | :--- |
| [`wx_text`](./packages/wx_text) | [![pub package](https://img.shields.io/pub/v/wx_text.svg)](https://pub.dev/packages/wx_text) | Core Flutter text utility featuring Material 3 typography shortcuts, gradient shaders, outline strokes, and pattern filters. | Flutter SDK (Zero external dependencies) |
| [`wx_text_spoiler`](./packages/wx_text_spoiler) | [![pub package](https://img.shields.io/pub/v/wx_text_spoiler.svg)](https://pub.dev/packages/wx_text_spoiler) | Expandable and collapsible spoiler / read-more text widget with reactive controller. | `wx_text` |
| [`wx_text_animated`](./packages/wx_text_animated) | [![pub package](https://img.shields.io/pub/v/wx_text_animated.svg)](https://pub.dev/packages/wx_text_animated) | Seamless typography animations (typing, shimmer, zoom, slide, shake, fade). | `wx_text`, `animated_repeatable` |

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
