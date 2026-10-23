import 'package:flutter/widgets.dart';
import 'child.dart';
import 'switcher_theme.dart';

/// A widget that switches between child widgets based on events with smooth animations.
class DrivenSwitcher extends DrivenChild<Widget> {
  /// Creates a `DrivenSwitcher`.
  const DrivenSwitcher(
    super.atEnabled, {
    super.atError,
    super.atDisabled,
    super.atLoading,
    super.atDragged,
    super.atPressed,
    super.atHovered,
    super.atFocused,
    super.atIndeterminate,
    super.atSelected,
    super.registry,
    super.key,
    this.duration,
    this.reverseDuration,
    this.switchInCurve,
    this.switchOutCurve,
    this.transitionBuilder,
    this.layoutBuilder,
    this.maintainKey = true,
  });

  /// Creates a `DrivenSwitcher` with custom registry.
  const DrivenSwitcher.map(
    super.atEnabled,
    super.registry, {
    super.key,
    this.duration,
    this.reverseDuration,
    this.switchInCurve,
    this.switchOutCurve,
    this.transitionBuilder,
    this.layoutBuilder,
    this.maintainKey = true,
  }) : super.map();

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

  /// The builder function used to customize the layout.
  final AnimatedSwitcherLayoutBuilder? layoutBuilder;

  /// Whether to maintain a key for the child widget during switching.
  final bool maintainKey;

  @override
  Widget build(BuildContext context) {
    final theme = DrivenSwitcherTheme.of(context);
    final effectiveDuration = duration ?? theme.duration ?? const Duration(milliseconds: 200);
    final effectiveReverseDuration = reverseDuration ?? theme.reverseDuration;
    final effectiveSwitchInCurve = switchInCurve ?? theme.switchInCurve ?? Curves.linear;
    final effectiveSwitchOutCurve = switchOutCurve ?? theme.switchOutCurve ?? Curves.linear;
    final effectiveTransitionBuilder = transitionBuilder ??
        theme.transitionBuilder ??
        AnimatedSwitcher.defaultTransitionBuilder;
    final effectiveLayoutBuilder = layoutBuilder ??
        theme.layoutBuilder ??
        AnimatedSwitcher.defaultLayoutBuilder;

    Widget child = super.build(context);
    if (maintainKey) {
      child = KeyedSubtree(
        key: ValueKey<Widget>(child),
        child: child,
      );
    }

    return AnimatedSwitcher(
      duration: effectiveDuration,
      reverseDuration: effectiveReverseDuration,
      switchInCurve: effectiveSwitchInCurve,
      switchOutCurve: effectiveSwitchOutCurve,
      transitionBuilder: effectiveTransitionBuilder,
      layoutBuilder: effectiveLayoutBuilder,
      child: child,
    );
  }
}
