import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// A class that provides a theme extension of type [T] to the widget tree.
///
/// This class is used to inherit a theme extension down the widget tree. It
/// is similar to `InheritedWidget` but specifically designed for theme extensions.
class ThemeExtensionProvider<T extends ThemeExtension<T>>
    extends InheritedTheme {
  /// The theme extension data of type [T].
  final ThemeExtension<T> data;

  /// Creates a [ThemeExtensionProvider].
  ///
  /// The [key] argument can be used to identify this widget in the widget tree.
  ///
  /// The [data] argument is the theme extension data of type [T] that will
  /// be inherited by the child widgets.
  ///
  /// The [child] argument is the widget below which the theme extension will
  /// be available.
  const ThemeExtensionProvider({
    super.key,
    required this.data,
    required super.child,
  });

  /// The [data] from the closest instance of
  /// this class that encloses the given context.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// ThemeExtension<T> theme = ThemeExtensionProvider.maybeOf<T>(context);
  /// ```
  static ThemeExtension<T>? maybeOf<T extends ThemeExtension<T>>(
    BuildContext context,
  ) {
    final parentTheme =
        context.dependOnInheritedWidgetOfExactType<ThemeExtensionProvider<T>>();
    if (parentTheme != null) return parentTheme.data;

    final globalTheme = Theme.of(context).extension<T>();
    return globalTheme;
  }

  /// The [data] from the closest instance of
  /// this class that encloses the given context.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// ThemeExtension<T> theme = ThemeExtensionProvider.of<T>(context);
  /// ```
  static ThemeExtension<T> of<T extends ThemeExtension<T>>(
    BuildContext context,
  ) {
    final themeData = maybeOf<T>(context);
    assert(themeData != null, 'No ThemeExtensionProvider<T> found in context');
    return themeData!;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    /// Wraps the child widget with a new instance of [ThemeExtensionProvider].
    return ThemeExtensionProvider<T>(data: data, child: child);
  }

  @override
  bool updateShouldNotify(ThemeExtensionProvider<T> oldWidget) {
    /// Returns true if the [data] property has changed.
    return oldWidget.data != data;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    /// Adds a diagnostic property for the [data] field.
    properties.add(DiagnosticsProperty('data', data));
  }
}
