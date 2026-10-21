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
  });

  /// The height of each item in the picker.
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
    );
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
            clipBehavior == other.clipBehavior;
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
