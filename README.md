# flutter_wx

Monorepo resmi untuk seluruh ekosistem pustaka komponen Flutter dari [davigmacode](https://github.com/davigmacode).

## 📦 Packages

| Package | Version | Description | Dependencies |
| :--- | :--- | :--- | :--- |
| [`wx_text`](./packages/wx_text) | [![pub package](https://img.shields.io/pub/v/wx_text.svg)](https://pub.dev/packages/wx_text) | Core Flutter Text utility with Material 3 styling, gradient shaders, outline stroke, and pattern filters. | Flutter SDK (Zero external dependencies) |
| [`wx_text_spoiler`](./packages/wx_text_spoiler) | [![pub package](https://img.shields.io/pub/v/wx_text_spoiler.svg)](https://pub.dev/packages/wx_text_spoiler) | Expandable and collapsible spoiler text widget with reactive controller. | `wx_text` |
| [`wx_text_animated`](./packages/wx_text_animated) | [![pub package](https://img.shields.io/pub/v/wx_text_animated.svg)](https://pub.dev/packages/wx_text_animated) | Typography animations (typing, shimmer, zoom, slide, shake, fade). | `wx_text`, `animated_repeatable` |

---

## 🚀 Workspace Architecture

Monorepo ini dikonfigurasi dengan:
- **Dart 3.5+ Native Workspaces**: Resolusi dependensi lokal instan dan satu `pubspec.lock` bersama.
- **Melos**: Orkestrasi multi-package task, automated semantic versioning, dan deployment ke pub.dev.
- **Example Showroom**: Aplikasi showroom multiplatform di direktori [`example/`](./example).

### Developer Commands

```bash
# Resolve dependencies across all workspace packages
dart pub get

# Run analyzer across all packages
dart run melos run analyze

# Run tests with coverage across all packages
dart run melos run test

# Format code
dart run melos run format
```

## 📄 License

MIT License © [davigmacode](https://github.com/davigmacode)
