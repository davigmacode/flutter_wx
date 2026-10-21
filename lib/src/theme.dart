import 'dart:ui' as ui;
import 'package:flutter/widgets.dart';
import 'effect.dart';

/// Configuration data for styling [WheelChoice] widgets across a subtree.
@immutable
class WheelChoiceThemeData {
  /// Creates a theme configuration for [WheelChoice].
  const WheelChoiceThemeData({
    this.itemExtent,
    this.itemVisible,
    this.effect,
    this.overlay,
    this.haptics,
    this.keyboard,
    this.physics,
    this.clipBehavior,
    this.scrollDirection,
  });

  /// The height (or width in horizontal mode) of each item in the picker.
  final double? itemExtent;

  /// Number of visible items in the viewport.
  final int? itemVisible;

  /// Visual 3D effects configuration.
  final WheelEffect? effect;

  /// An optional overlay builder displayed on top of the picker.
  final WidgetBuilder? overlay;

  /// Whether haptic feedback is enabled on scroll.
  final bool? haptics;

  /// Whether keyboard navigation is enabled.
  final bool? keyboard;

  /// Optional scroll physics.
  final ScrollPhysics? physics;

  /// Optional viewport clipping behavior.
  final Clip? clipBehavior;

  /// The scrolling orientation (`Axis.vertical` or `Axis.horizontal`).
  final Axis? scrollDirection;

  /// Creates a copy of this theme with the given fields replaced.
  WheelChoiceThemeData copyWith({
    double? itemExtent,
    int? itemVisible,
    WheelEffect? effect,
    WidgetBuilder? overlay,
    bool? haptics,
    bool? keyboard,
    ScrollPhysics? physics,
    Clip? clipBehavior,
    Axis? scrollDirection,
  }) {
    return WheelChoiceThemeData(
      itemExtent: itemExtent ?? this.itemExtent,
      itemVisible: itemVisible ?? this.itemVisible,
      effect: effect ?? this.effect,
      overlay: overlay ?? this.overlay,
      haptics: haptics ?? this.haptics,
      keyboard: keyboard ?? this.keyboard,
      physics: physics ?? this.physics,
      clipBehavior: clipBehavior ?? this.clipBehavior,
      scrollDirection: scrollDirection ?? this.scrollDirection,
    );
  }

  /// Merges another [WheelChoiceThemeData] into this one.
  WheelChoiceThemeData merge(WheelChoiceThemeData? other) {
    if (other == null) return this;
    return copyWith(
      itemExtent: other.itemExtent,
      itemVisible: other.itemVisible,
      effect: other.effect,
      overlay: other.overlay,
      haptics: other.haptics,
      keyboard: other.keyboard,
      physics: other.physics,
      clipBehavior: other.clipBehavior,
      scrollDirection: other.scrollDirection ?? scrollDirection,
    );
  }

  /// Linearly interpolates between two [WheelChoiceThemeData]s.
  static WheelChoiceThemeData? lerp(
    WheelChoiceThemeData? a,
    WheelChoiceThemeData? b,
    double t,
  ) {
    if (identical(a, b)) return a;
    return WheelChoiceThemeData(
      itemExtent: ui.lerpDouble(a?.itemExtent, b?.itemExtent, t),
      itemVisible: t < 0.5 ? a?.itemVisible : b?.itemVisible,
      effect: b?.effect ?? a?.effect,
      overlay: t < 0.5 ? a?.overlay : b?.overlay,
      haptics: t < 0.5 ? a?.haptics : b?.haptics,
      keyboard: t < 0.5 ? a?.keyboard : b?.keyboard,
      physics: t < 0.5 ? a?.physics : b?.physics,
      clipBehavior: t < 0.5 ? a?.clipBehavior : b?.clipBehavior,
      scrollDirection: t < 0.5 ? a?.scrollDirection : b?.scrollDirection,
    );
  }

  @override
  String toString() {
    return 'WheelChoiceThemeData('
        'itemExtent: $itemExtent, '
        'itemVisible: $itemVisible, '
        'effect: $effect, '
        'overlay: $overlay, '
        'haptics: $haptics, '
        'keyboard: $keyboard, '
        'physics: $physics, '
        'clipBehavior: $clipBehavior, '
        'scrollDirection: $scrollDirection)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is WheelChoiceThemeData &&
            runtimeType == other.runtimeType &&
            itemExtent == other.itemExtent &&
            itemVisible == other.itemVisible &&
            effect == other.effect &&
            overlay == other.overlay &&
            haptics == other.haptics &&
            keyboard == other.keyboard &&
            physics == other.physics &&
            clipBehavior == other.clipBehavior &&
            scrollDirection == other.scrollDirection;
  }

  @override
  int get hashCode => Object.hash(
        itemExtent,
        itemVisible,
        effect,
        overlay,
        haptics,
        keyboard,
        physics,
        clipBehavior,
        scrollDirection,
      );
}

/// An [InheritedTheme] that defines styling and defaults for [WheelChoice]
/// widgets in a subtree.
class WheelChoiceTheme extends InheritedTheme {
  /// Applies the given [data] to child [WheelChoice] widgets.
  const WheelChoiceTheme({
    super.key,
    required this.data,
    required super.child,
  });

  /// The configuration data applied by this theme.
  final WheelChoiceThemeData data;

  /// Returns the nearest [WheelChoiceThemeData] ancestor, or null if none exists.
  static WheelChoiceThemeData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<WheelChoiceTheme>()?.data;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return WheelChoiceTheme(data: data, child: child);
  }

  @override
  bool updateShouldNotify(covariant WheelChoiceTheme oldWidget) {
    return data != oldWidget.data;
  }
}
