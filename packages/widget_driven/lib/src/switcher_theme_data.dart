import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Defines the visual properties of [DrivenSwitcher].
class DrivenSwitcherThemeData extends ThemeExtension<DrivenSwitcherThemeData>
    with Diagnosticable {
  /// Whether to maintain keys during switching.
  final bool maintainKey;

  /// The duration of the switch animation.
  final Duration? duration;

  /// The duration of the reverse switch animation.
  final Duration? reverseDuration;

  /// The curve used for the switch-in animation.
  final Curve? switchInCurve;

  /// The curve used for the switch-out animation.
  final Curve? switchOutCurve;

  /// The builder function used to customize the switch animation.
  final AnimatedSwitcherTransitionBuilder? transitionBuilder;

  /// The builder function used to customize the layout of the AnimatedSwitcher.
  final AnimatedSwitcherLayoutBuilder? layoutBuilder;

  /// Creates a theme data that can be used for [DrivenSwitcherTheme].
  const DrivenSwitcherThemeData({
    this.duration,
    this.reverseDuration,
    this.switchInCurve,
    this.switchOutCurve,
    this.transitionBuilder,
    this.layoutBuilder,
    this.maintainKey = true,
  });

  /// Creates a [DrivenSwitcherThemeData] from another one that is probably null.
  DrivenSwitcherThemeData.from([
    DrivenSwitcherThemeData? other,
    DrivenSwitcherThemeData fallback = const DrivenSwitcherThemeData(),
  ])  : duration = other?.duration ?? fallback.duration,
        reverseDuration = other?.reverseDuration ?? fallback.reverseDuration,
        switchInCurve = other?.switchInCurve ?? fallback.switchInCurve,
        switchOutCurve = other?.switchOutCurve ?? fallback.switchOutCurve,
        transitionBuilder = other?.transitionBuilder ?? fallback.transitionBuilder,
        layoutBuilder = other?.layoutBuilder ?? fallback.layoutBuilder,
        maintainKey = other?.maintainKey ?? fallback.maintainKey;

  /// Creates a copy of this [DrivenSwitcherThemeData] with replaced fields.
  @override
  DrivenSwitcherThemeData copyWith({
    Duration? duration,
    Duration? reverseDuration,
    Curve? switchInCurve,
    Curve? switchOutCurve,
    AnimatedSwitcherTransitionBuilder? transitionBuilder,
    AnimatedSwitcherLayoutBuilder? layoutBuilder,
    bool? maintainKey,
  }) {
    return DrivenSwitcherThemeData(
      duration: duration ?? this.duration,
      reverseDuration: reverseDuration ?? this.reverseDuration,
      switchInCurve: switchInCurve ?? this.switchInCurve,
      switchOutCurve: switchOutCurve ?? this.switchOutCurve,
      transitionBuilder: transitionBuilder ?? this.transitionBuilder,
      layoutBuilder: layoutBuilder ?? this.layoutBuilder,
      maintainKey: maintainKey ?? this.maintainKey,
    );
  }

  /// Linearly interpolate with another [DrivenSwitcherThemeData].
  @override
  DrivenSwitcherThemeData lerp(DrivenSwitcherThemeData? other, double t) {
    if (other == null) return this;
    return DrivenSwitcherThemeData(
      duration: t < 0.5 ? duration : other.duration,
      reverseDuration: t < 0.5 ? reverseDuration : other.reverseDuration,
      switchInCurve: t < 0.5 ? switchInCurve : other.switchInCurve,
      switchOutCurve: t < 0.5 ? switchOutCurve : other.switchOutCurve,
      transitionBuilder: t < 0.5 ? transitionBuilder : other.transitionBuilder,
      layoutBuilder: t < 0.5 ? layoutBuilder : other.layoutBuilder,
      maintainKey: t < 0.5 ? maintainKey : other.maintainKey,
    );
  }

  /// Merges this with another [DrivenSwitcherThemeData].
  DrivenSwitcherThemeData merge(DrivenSwitcherThemeData? other) {
    if (other == null) return this;
    return copyWith(
      duration: other.duration,
      reverseDuration: other.reverseDuration,
      switchInCurve: other.switchInCurve,
      switchOutCurve: other.switchOutCurve,
      transitionBuilder: other.transitionBuilder,
      layoutBuilder: other.layoutBuilder,
      maintainKey: other.maintainKey,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is DrivenSwitcherThemeData &&
        other.duration == duration &&
        other.reverseDuration == reverseDuration &&
        other.switchInCurve == switchInCurve &&
        other.switchOutCurve == switchOutCurve &&
        other.transitionBuilder == transitionBuilder &&
        other.layoutBuilder == layoutBuilder &&
        other.maintainKey == maintainKey;
  }

  @override
  int get hashCode => Object.hash(
        duration,
        reverseDuration,
        switchInCurve,
        switchOutCurve,
        transitionBuilder,
        layoutBuilder,
        maintainKey,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Duration?>('duration', duration));
    properties.add(DiagnosticsProperty<Duration?>('reverseDuration', reverseDuration));
    properties.add(DiagnosticsProperty<Curve?>('switchInCurve', switchInCurve));
    properties.add(DiagnosticsProperty<Curve?>('switchOutCurve', switchOutCurve));
    properties.add(DiagnosticsProperty<bool>('maintainKey', maintainKey));
  }
}
