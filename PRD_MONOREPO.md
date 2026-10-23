# PRD & Technical Specification: `flutter_wx` Monorepo

## 1. Overview & Vision
`flutter_wx` adalah monorepo resmi untuk seluruh ekosistem pustaka komponen Flutter dari **davigmacode** (`wx_*`). Monorepo ini mengintegrasikan seluruh paket di bawah satu repositori terpusat dengan:
- **Dart 3.5+ Native Workspaces** untuk resolusi dependensi lokal yang instan dan satu `pubspec.lock` bersama.
- **Melos** untuk orkestrasi task multi-package (test, analyze, bootstrap) serta otomatisasi semantic versioning dan penerbitan ke pub.dev.
- **Zero-Dependency Core**: Memisahkan fitur berat seperti animasi atau spoiler ke paket modular terpisah, menjadikan `wx_text` sangat ringan dan murni di atas Flutter SDK.

---

## 2. Struktur Direktori Monorepo (`D:\packages\flutter\flutter_wx\`)

```text
flutter_wx/
├── .github/
│   └── workflows/
│       ├── test.yml                   # CI: multi-package analyze & tests via Melos
│       └── release.yml                # CD: automated pub.dev release via Melos & OIDC
├── packages/
│   ├── wx_text/                       # Core Text Utility (v4.0.0, Zero External Deps)
│   ├── wx_text_spoiler/               # Expandable Spoiler Text Widget (v1.0.0)
│   ├── wx_text_animated/              # Typography Animation Widget (v1.0.0, deps: animated_repeatable)
│   └── (future wx_* packages)         # wx_box, wx_button, wx_avatar, wx_sheet, dll.
├── example/                           # Showroom / Gallery Flutter Web & Desktop app
├── melos.yaml                         # Konfigurasi Melos Workspace
├── pubspec.yaml                       # Root Dart 3.5+ Workspace Pubspec
├── analysis_options.yaml              # Single Source of Truth Linter
└── README.md                          # Dokumentasi monorepo dan badge ekosistem
```

---

## 3. Spesifikasi Paket-Paket Tahap 1

### A. `packages/wx_text` (Core Text, v4.0.0)
- **Tujuan**: Komponen inti teks Flutter dengan Material 3 typography shortcuts, gradient shader, outline stroke, pattern filter (regex URL, email, mention, phone), dan baris constraints.
- **Dependensi Eksternal**: **Nol (0)**. Hanya bergantung pada `flutter` SDK.
- **File Inti**:
  - `lib/wx_text.dart`
  - `lib/src/base.dart`
  - `lib/src/constrained.dart`
  - `lib/src/filter.dart`
  - `lib/src/gradient.dart`
  - `lib/src/outlined.dart`
  - `lib/src/parsed.dart`
  - `lib/src/styler.dart`
  - `lib/src/variant.dart`
  - `lib/src/widget.dart`
- **Breaking Change dari v3.1.0**: `WxSpoilerText` dan `WxAnimatedText` dipindahkan ke paket masing-masing.

### B. `packages/wx_text_spoiler` (v1.0.0)
- **Tujuan**: Widget teks expandable/collapsible ("Read more / Show less") dengan controller reaktif dan animasi transisi.
- **Dependensi**: `flutter` SDK, `wx_text: ^4.0.0`.
- **File Inti**:
  - `lib/wx_text_spoiler.dart`
  - `lib/src/controller.dart` (`WxSpoilerController`, `WxSpoilerProvider`)
  - `lib/src/widget.dart` (`WxSpoilerText`)
- **Fitur Baru**: Dukungan `controller` eksternal dan method reaktif `expand()`, `collapse()`, `toggle()`.

### C. `packages/wx_text_animated` (v1.0.0)
- **Tujuan**: Efek animasi teks dinamis (typing typewriter, shimmer gradient, slide, shake, zoom, fade).
- **Dependensi**: `flutter` SDK, `wx_text: ^4.0.0`, `animated_repeatable: ^1.2.0`.
- **File Inti**:
  - `lib/wx_text_animated.dart`
  - `lib/src/widget.dart` (`WxAnimatedText`, preset transitions)

---

## 4. Konfigurasi Root Workspace

### `pubspec.yaml` (Root)
```yaml
name: flutter_wx_workspace
publish_to: none

environment:
  sdk: '>=3.5.0 <4.0.0'

workspace:
  - packages/wx_text
  - packages/wx_text_spoiler
  - packages/wx_text_animated
  - example

dev_dependencies:
  melos: ^6.3.0
  flutter_lints: ^5.0.0
```

### `melos.yaml`
```yaml
name: flutter_wx
repository: https://github.com/davigmacode/flutter_wx

packages:
  - packages/**
  - example

command:
  version:
    generateCommitChangelog: true
    linkToCommits: true
    workspaceChangelog: true

scripts:
  analyze:
    run: melos exec -- "flutter analyze"
    description: Run flutter analyze across all packages.

  test:
    run: melos exec --dir-exists="test" -- "flutter test --coverage"
    description: Run flutter test in all packages.

  format:
    run: dart format .
    description: Format Dart code across the repository.
```

---

## 5. Strategi Migrasi Paket Lain (`wx_*`)

Untuk paket yang sudah ada (`wx_box`, `wx_button`, `wx_avatar`, `wx_sheet`, dsb.), riwayat commit Git dipertahankan 100% menggunakan Git Subtree:
```powershell
# Contoh migrasi wx_button ke monorepo
git remote add origin-wx-button https://github.com/davigmacode/wx_button.git
git fetch origin-wx-button
git subtree add --prefix=packages/wx_button origin-wx-button main
git remote remove origin-wx-button
```

---

## 6. Kriteria Keberhasilan (Definition of Done)
1. `dart run melos run analyze` menghasilkan **0 issues** di semua package dan example.
2. `dart run melos run test` lolos **100%** di semua package.
3. `dart pub publish --dry-run` menghasilkan **0 warnings** untuk setiap package terpisah.
4. Git commit history dari `wx_text` tetap utuh.
