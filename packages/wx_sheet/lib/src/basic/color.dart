import 'package:flutter/material.dart';
import 'package:wx_sheet/wx_event.dart';

/// Semantic color roles inspired by modern utility-first design systems.
///
/// Can be used directly as a [Color] anywhere in `wx_sheet`, including
/// `severity: WxColor.danger` or `backgroundColor: WxColor.primary`.
class WxColor extends Color {
  /// Create a custom [WxColor].
  const WxColor(super.value);

  /// Primary brand color.
  static const primary = WxColor(0xFF1E88E5);

  /// Secondary brand / muted color.
  static const secondary = WxColor(0xFF6C757D);

  /// Accent / highlights color.
  static const accent = WxColor(0xFF8B5CF6);

  /// Neutral background/surface color.
  static const neutral = WxColor(0xFF374151);

  /// Informational status color.
  static const info = WxColor(0xFF0284C7);

  /// Success status color.
  static const success = WxColor(0xFF16A34A);

  /// Warning status color.
  static const warning = WxColor(0xFFEA580C);

  /// Danger / error status color.
  static const danger = WxColor(0xFFDC2626);

  /// Create an event-driven [DrivenColor] resolved dynamically.
  static DrivenColor resolveWith(DrivenPropertyResolver<Color> callback) {
    return DrivenColor.by(callback);
  }

  /// Resolves standard semantic role from the active [ColorScheme].
  static Color fromScheme(
    ColorScheme scheme, {
    Color? fallback,
    bool isDanger = false,
    bool isWarning = false,
    bool isSuccess = false,
    bool isInfo = false,
  }) {
    if (isDanger) return scheme.error;
    if (isWarning) return const Color(0xFFEA580C);
    if (isSuccess) return const Color(0xFF16A34A);
    if (isInfo) return const Color(0xFF0284C7);
    return fallback ?? scheme.primary;
  }
}
