import 'package:flutter/material.dart';
import 'package:wx_sheet/wx_sheet.dart';
import 'theme_data.dart';
import 'theme_preset.dart';
import 'style.dart';

class WxChipTheme extends WxSheetTheme<WxChipThemeData> {
  /// Creates a theme that controls
  /// how descendant [WxChip]s should look like.
  const WxChipTheme({
    super.key,
    required WxChipThemeData super.data,
    required super.child,
  });

  /// Creates an [WxChipTheme] that controls the style of
  /// descendant widgets, and merges in the current [WxChipTheme], if any.
  ///
  /// The [style] and [child] arguments must not be null.
  static Widget merge({
    Key? key,
    Curve? curve,
    Duration? duration,
    WxSheetVariant? variant,
    WxSheetSize? size,
    Color? severity,
    WxChipStyle? style,
    WxSheetStyleResolver<WxChipStyle>? styleResolver,
    bool? overlay,
    bool? feedback,
    bool? focusable,
    bool? disabled,
    MouseCursor? mouseCursor,
    Widget? leading,
    Widget? trailing,
    WxChipThemeData? data,
    required Widget child,
  }) {
    return Builder(
      builder: (BuildContext context) {
        final parent = WxChipTheme.of(context);
        return WxChipTheme(
          key: key,
          data: parent.merge(data).copyWith(
                curve: curve,
                duration: duration,
                variant: variant,
                size: size,
                severity: severity,
                style: style,
                styleResolver: styleResolver,
                overlay: overlay,
                feedback: feedback,
                focusable: focusable,
                disabled: disabled,
                mouseCursor: mouseCursor,
                leading: leading,
                trailing: trailing,
              ),
          child: child,
        );
      },
    );
  }

  /// The [data] from the closest instance of
  /// this class that encloses the given context.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// WxChipThemeData theme = WxChipTheme.of(context);
  /// ```
  static WxChipThemeData? maybeOf(BuildContext context) {
    final parentTheme =
        context.dependOnInheritedWidgetOfExactType<WxChipTheme>();
    if (parentTheme != null) {
      return WxChipThemeData.fromAncestor(parentTheme.data);
    }

    final globalTheme = Theme.of(context).extension<WxChipThemeData>();
    return globalTheme;
  }

  /// The [data] from the closest instance of
  /// this class that encloses the given context.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// WxChipThemeData theme = WxChipTheme.of(context);
  /// ```
  static WxChipThemeData of(BuildContext context) {
    final parent = WxChipTheme.maybeOf(context);
    if (parent != null) return parent;

    return WxChipThemeAdaptive(context);
  }
}
