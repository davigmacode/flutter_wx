import 'package:flutter/material.dart';
import 'data.dart';

@immutable
class ColorThemeDefaults extends ColorThemeData {
  ColorThemeDefaults(
    this.context, [
    ColorThemeData? other,
  ])  : appTheme = Theme.of(context),
        super.from(other);

  final BuildContext context;

  final ThemeData appTheme;

  ColorScheme get colorScheme => appTheme.colorScheme;

  Brightness get brightness => colorScheme.brightness;

  Color get unselectedWidgetColor => appTheme.unselectedWidgetColor;

  Color get background => colorScheme.background;
  Color get outline => colorScheme.outline;
  Color get shadow => colorScheme.shadow;

  Color get surface => colorScheme.surface;
  Color get surfaceTint => colorScheme.surfaceTint;
  Color get surfaceVariant => colorScheme.surfaceVariant;
  Color get onSurface => colorScheme.onSurface;
  Color get onSurfaceVariant => colorScheme.onSurfaceVariant;

  Color get primary => colorScheme.primary;
  Color get primaryContainer => colorScheme.primaryContainer;
  Color get onPrimary => colorScheme.onPrimary;
  Color get onPrimaryContainer => colorScheme.onPrimaryContainer;

  Color get secondary => colorScheme.secondary;
  Color get secondaryContainer => colorScheme.secondaryContainer;
  Color get onSecondary => colorScheme.onSecondary;
  Color get onSecondaryContainer => colorScheme.onSecondaryContainer;

  Color get tertiary => colorScheme.tertiary;
  Color get tertiaryContainer => colorScheme.tertiaryContainer;
  Color get onTertiary => colorScheme.onTertiary;
  Color get onTertiaryContainer => colorScheme.onTertiaryContainer;

  Color get inversePrimary => colorScheme.inversePrimary;
  Color get inverseSurface => colorScheme.inverseSurface;
  Color get onInverseSurface => colorScheme.onInverseSurface;

  Color get error => colorScheme.error;
  Color get errorContainer => colorScheme.errorContainer;
  Color get onError => colorScheme.onError;
  Color get onErrorContainer => colorScheme.onErrorContainer;
}
