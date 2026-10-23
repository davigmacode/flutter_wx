import 'package:flutter/material.dart';

/// An overlay shown on top of the wheel viewport, typically to
/// highlight the currently selected row.
///
/// Usage:
/// ```dart
/// // Outlined style (top/bottom lines) with horizontal inset
/// WheelOverlay.outlined(inset: 12);
///
/// // Filled rounded box style
/// WheelOverlay.filled(color: Colors.black12, cornerRadius: 8, inset: 16);
/// ```
class WheelOverlay extends StatelessWidget {
  const WheelOverlay({
    super.key,
    this.builder,
    this.extent,
    this.offset,
    this.axis = Axis.vertical,
    required this.child,
  });

  /// Optional builder that paints the overlay content.
  /// If `null`, only [child] is displayed.
  final WidgetBuilder? builder;

  /// Height (or width in horizontal mode) of the overlay box. Usually matches
  /// the item extent.
  final double? extent;

  /// Offset applied to the overlay along the scrolling axis.
  final double? offset;

  /// The scrolling orientation of the wheel.
  final Axis axis;

  /// The underlying wheel view.
  final Widget child;

  /// Creates a default overlay box with optional border and background color.
  ///
  /// Props:
  /// - [color]: Background color inside the overlay bounds.
  /// - [border]: Custom border (e.g. `Border.all(...)`).
  /// - [borderRadius]: Rounded corners for the overlay box.
  /// - [margin]: Insets around the overlay box.
  static WidgetBuilder delegate({
    Color? color,
    BoxBorder? border,
    BorderRadiusGeometry? borderRadius,
    EdgeInsetsGeometry? margin,
  }) {
    return (context) {
      return Container(
        margin: margin,
        decoration: BoxDecoration(
          border: border,
          borderRadius: borderRadius,
          color: color,
        ),
      );
    };
  }

  /// Creates an overlay with border lines (horizontal for vertical wheel,
  /// vertical for horizontal wheel).
  ///
  /// Props:
  /// - [borderColor]: Color for the highlight lines.
  /// - [inset]: Space around the lines perpendicular to scrolling.
  /// - [axis]: Scrolling orientation (`Axis.vertical` or `Axis.horizontal`).
  static WidgetBuilder outlined({
    Color? borderColor,
    double? inset,
    Axis axis = Axis.vertical,
  }) {
    return (context) {
      final theme = Theme.of(context);
      final borderSide = BorderSide(
        color: borderColor ?? theme.colorScheme.outlineVariant,
      );
      final border = axis == Axis.vertical
          ? Border.symmetric(horizontal: borderSide)
          : Border.symmetric(vertical: borderSide);
      final margin = axis == Axis.vertical
          ? EdgeInsets.symmetric(horizontal: inset ?? 0)
          : EdgeInsets.symmetric(vertical: inset ?? 0);

      return WheelOverlay.delegate(
        border: border,
        margin: margin,
      )(context);
    };
  }

  /// Creates an overlay with a rounded background and margin inset.
  ///
  /// Props:
  /// - [color]: Fill color inside the overlay bounds.
  /// - [cornerRadius]: Corner radius for the rounded rectangle.
  /// - [inset]: Space around the overlay perpendicular to scrolling.
  /// - [axis]: Scrolling orientation (`Axis.vertical` or `Axis.horizontal`).
  static WidgetBuilder filled({
    Color? color,
    double? cornerRadius,
    double? inset,
    Axis axis = Axis.vertical,
  }) {
    return WheelOverlay.delegate(
      color: color ?? Colors.black12,
      borderRadius: BorderRadius.circular(cornerRadius ?? 6),
      margin: axis == Axis.vertical
          ? EdgeInsets.symmetric(horizontal: inset ?? 16)
          : EdgeInsets.symmetric(vertical: inset ?? 16),
    );
  }

  @override

  /// Builds the wheel with the overlay stacked on top when [builder] is set.
  Widget build(BuildContext context) {
    if (builder != null) {
      Widget overlay = IgnorePointer(
        child: SizedBox(
          width: axis == Axis.horizontal ? extent : null,
          height: axis == Axis.vertical ? extent : null,
          child: builder!(context),
        ),
      );
      if (offset != null) {
        overlay = Transform.translate(
          offset: axis == Axis.vertical
              ? Offset(0, offset! / 2)
              : Offset(offset! / 2, 0),
          child: overlay,
        );
      }
      return Stack(
        alignment: Alignment.center,
        children: [child, overlay],
      );
    }
    return child;
  }
}
