import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'switcher_theme_data.dart';

/// A Widget that controls how descendant [DrivenSwitcher]s look and animate.
class DrivenSwitcherTheme extends InheritedTheme {
  /// The properties for descendant [DrivenSwitcher]s.
  final DrivenSwitcherThemeData data;

  /// Creates a theme for descendant [DrivenSwitcher]s.
  const DrivenSwitcherTheme({
    super.key,
    required this.data,
    required super.child,
  });

  /// Merges with the nearest [DrivenSwitcherTheme].
  static Widget merge({
    Key? key,
    Duration? duration,
    Duration? reverseDuration,
    Curve? switchInCurve,
    Curve? switchOutCurve,
    AnimatedSwitcherTransitionBuilder? transitionBuilder,
    AnimatedSwitcherLayoutBuilder? layoutBuilder,
    bool? maintainKey,
    DrivenSwitcherThemeData? data,
    required Widget child,
  }) {
    return Builder(
      builder: (BuildContext context) {
        final parent = DrivenSwitcherTheme.of(context);
        return DrivenSwitcherTheme(
          key: key,
          data: parent.merge(data).copyWith(
                duration: duration,
                reverseDuration: reverseDuration,
                switchInCurve: switchInCurve,
                switchOutCurve: switchOutCurve,
                transitionBuilder: transitionBuilder,
                layoutBuilder: layoutBuilder,
                maintainKey: maintainKey,
              ),
          child: child,
        );
      },
    );
  }

  /// Obtains the [DrivenSwitcherThemeData] from the closest instance in context.
  static DrivenSwitcherThemeData? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DrivenSwitcherTheme>()?.data;
  }

  /// Obtains the [DrivenSwitcherThemeData] from the closest instance in context or default.
  static DrivenSwitcherThemeData of(BuildContext context) {
    return maybeOf(context) ??
        Theme.of(context).extension<DrivenSwitcherThemeData>() ??
        const DrivenSwitcherThemeData();
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return DrivenSwitcherTheme(data: data, child: child);
  }

  @override
  bool updateShouldNotify(DrivenSwitcherTheme oldWidget) => data != oldWidget.data;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<DrivenSwitcherThemeData>('data', data));
  }
}
