## 1.3.0
- Horizontal Orientation: Added `scrollDirection` support (`Axis.vertical` and `Axis.horizontal`) via hardware-accelerated `RotatedBox` transformation with full gesture and 3D snapping support.
- Null Safety & Explicit Null Option: Supported nullable item options (`WheelChoice<T?>`), explicit unselected slots, and returned `selectedIndex = -1` when options list is empty.
- Subtree Theming: Added `WheelChoiceTheme` and `WheelChoiceThemeData` with `lerp`, `copyWith`, `merge`, and `toString` to cascade consistent styling down the widget tree.
- Form Integration: Added `WheelChoiceFormField<T>` extending Flutter's `FormField<T>` with validation, `InputDecoration` error rendering, `onSaved`, and `reset` support.
- DX & Navigation: Added `next()`, `previous()`, `hasNext`, and `hasPrevious` to `WheelController` for programmatic stepped increments.
- Callbacks: Added `onIndexChanged` callback to `WheelChoice` and `WheelController`.
- Performance:
  - Optimized `WheelController.selectedIndex` to $O(1)$ lookup via `_indexNotifier.value`.
  - Item builders are isolated with `ValueListenableBuilder<T?>`, avoiding unnecessary parent rebuilds during scroll and selection changes.
- Bug Fixes & Refinements:
  - Fixed shortest-path circular loop snapping in `handleScrollEnd` and `_findNearestEnabledIndexLoop`.
  - Guarded against `positions.isNotEmpty` / `hasClients` assertion when methods are called prior to widget attachment.
  - Added modulo normalization (`_normalizeMod`) and out-of-bounds safety guards in scroll listeners.
  - Fixed `didUpdateWidget` synchronization when `options` change dynamically.
  - Fixed keyboard navigation shortcuts event routing hierarchy.
  - Included `label` in `WheelItem` equality and hash code.
- Examples & Docs:
  - Overhauled `example/lib/main.dart` showcasing Theming, Time Stepper, Custom Builder & Filled Overlay, Pure Reactive, and Dynamic Forms.
  - Expanded README with visual ASCII architecture, layout reference, and theming guide.

## 1.2.0
- Experimental: keyboard navigation (arrow up/down, PgUp/PgDn, Home/End) and
  haptic feedback on selection. Requires focus for keyboard; haptics only on
  supported devices. APIs may evolve.
- Reactive: added examples and docs for `valueListenable` and
  `indexListenable` to react without wiring `onChanged`.
- Safety: defer `onChanged` from scroll to next frame to avoid setState during
  build.
- Default ctor: lazily instantiates the internal controller on first use to
  avoid unnecessary creation when an external controller is provided later.
- Docs: expanded README (reactive listeners, keyboard/haptics notes) and
  DartDoc (constructors, props, experimental flags).

## 1.1.0
- New: `WheelController<T>` for programmatic control (set/jump/animate by
  value or index), plus `valueListenable` and `indexListenable` for reactive
  integrations.
- Behavior: Animated moves are disabled-aware (snap to nearest enabled);
  direct jumps can land on disabled by design.
- Widget: Added `physics` and `clipBehavior` props; improved expanded sizing
  (derives `itemExtent` from viewport and enforces odd `itemVisible`).
- UX: Better month/day and time pickers in example; mouse-drag scrolling in
  example; docs expanded with constructors and reactive listeners.
- Internal: Ownership model for controller (`WheelChoice(...)` owns and
  disposes; `WheelChoice.raw(...)` uses external controller).

## 1.0.1
- Fix: formatting to satisfy `dart format`/lints.

## 1.0.0
- Initial stable release.
- Core widgets and APIs:
  - `WheelChoice`: customizable wheel/slot-style picker.
  - `WheelHeader`: optional header row with styling.
  - `WheelItem.delegate`: default item renderer utilities.
  - `WheelOverlay`: outlined and filled selection overlays.
  - `WheelEffect`: 3D look, magnifier, and perspective settings.
- Example app:
  - Includes basic day picker, numeric minutes picker (multiples of 5), and a custom layout demo.
  - Desktop/web friendly: mouse drag scrolling enabled via `MaterialApp.scrollBehavior`.
- Metadata:
  - Package description updated (English).
