import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'spinner_theme_data.dart';

/// A Widget that controls how descendant [DrivenSpinner]s look.
class DrivenSpinnerTheme extends InheritedTheme {
  /// The properties for descendant [DrivenSpinner]s
  final DrivenSpinnerThemeData data;

  /// Creates a theme for descendant [DrivenSpinner]s.
  const DrivenSpinnerTheme({
    super.key,
    required this.data,
    required super.child,
  });

  /// Merges with the nearest [DrivenSpinnerTheme].
  static Widget merge({
    Key? key,
    double? size,
    Color? color,
    Color? backgroundColor,
    double? width,
    double? offset,
    bool? rounded,
    DrivenSpinnerThemeData? data,
    required Widget child,
  }) {
    return Builder(
      builder: (BuildContext context) {
        final parent = DrivenSpinnerTheme.of(context);
        return DrivenSpinnerTheme(
          key: key,
          data: parent.merge(data).copyWith(
                size: size,
                color: color,
                backgroundColor: backgroundColor,
                width: width,
                offset: offset,
                rounded: rounded,
              ),
          child: child,
        );
      },
    );
  }

  /// Obtains the [DrivenSpinnerThemeData] from the closest instance in context.
  static DrivenSpinnerThemeData? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DrivenSpinnerTheme>()?.data;
  }

  /// Obtains the [DrivenSpinnerThemeData] from the closest instance in context or default.
  static DrivenSpinnerThemeData of(BuildContext context) {
    return maybeOf(context) ??
        Theme.of(context).extension<DrivenSpinnerThemeData>() ??
        const DrivenSpinnerThemeData();
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return DrivenSpinnerTheme(data: data, child: child);
  }

  @override
  bool updateShouldNotify(DrivenSpinnerTheme oldWidget) => data != oldWidget.data;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<DrivenSpinnerThemeData>('data', data));
  }
}
