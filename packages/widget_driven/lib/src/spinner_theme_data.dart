import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Defines the visual properties of [DrivenSpinner].
class DrivenSpinnerThemeData extends ThemeExtension<DrivenSpinnerThemeData>
    with Diagnosticable {
  /// The size of the spinner.
  final double? size;

  /// The color of the spinner.
  final Color? color;

  /// The background color of the spinner.
  final Color? backgroundColor;

  /// The width of the spinner's stroke.
  final double width;

  /// The offset of the spinner's stroke.
  final double offset;

  /// Whether the spinner's stroke is rounded.
  final bool rounded;

  /// Creates a theme data that can be used for [DrivenSpinnerTheme].
  const DrivenSpinnerThemeData({
    this.size,
    this.color,
    this.backgroundColor,
    this.width = 4,
    this.offset = 0,
    this.rounded = true,
  });

  /// Creates a [DrivenSpinnerThemeData] from another one that probably null.
  DrivenSpinnerThemeData.from([
    DrivenSpinnerThemeData? other,
    DrivenSpinnerThemeData fallback = const DrivenSpinnerThemeData(),
  ])  : size = other?.size ?? fallback.size,
        color = other?.color ?? fallback.color,
        backgroundColor = other?.backgroundColor ?? fallback.backgroundColor,
        width = other?.width ?? fallback.width,
        offset = other?.offset ?? fallback.offset,
        rounded = other?.rounded ?? fallback.rounded;

  /// Creates a copy of this [DrivenSpinnerThemeData] with replaced fields.
  @override
  DrivenSpinnerThemeData copyWith({
    double? size,
    Color? color,
    Color? backgroundColor,
    double? width,
    double? offset,
    bool? rounded,
  }) {
    return DrivenSpinnerThemeData(
      size: size ?? this.size,
      color: color ?? this.color,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      width: width ?? this.width,
      offset: offset ?? this.offset,
      rounded: rounded ?? this.rounded,
    );
  }

  /// Linearly interpolate with another [DrivenSpinnerThemeData].
  @override
  DrivenSpinnerThemeData lerp(DrivenSpinnerThemeData? other, double t) {
    if (other == null) return this;
    return DrivenSpinnerThemeData(
      size: lerpDouble(size, other.size, t),
      color: Color.lerp(color, other.color, t),
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      width: lerpDouble(width, other.width, t) ?? width,
      offset: lerpDouble(offset, other.offset, t) ?? offset,
      rounded: t < 0.5 ? rounded : other.rounded,
    );
  }

  /// Merges this with another [DrivenSpinnerThemeData].
  DrivenSpinnerThemeData merge(DrivenSpinnerThemeData? other) {
    if (other == null) return this;
    return copyWith(
      size: other.size,
      color: other.color,
      backgroundColor: other.backgroundColor,
      width: other.width,
      offset: other.offset,
      rounded: other.rounded,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is DrivenSpinnerThemeData &&
        other.size == size &&
        other.color == color &&
        other.backgroundColor == backgroundColor &&
        other.width == width &&
        other.offset == offset &&
        other.rounded == rounded;
  }

  @override
  int get hashCode => Object.hash(
        size,
        color,
        backgroundColor,
        width,
        offset,
        rounded,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<double?>('size', size));
    properties.add(DiagnosticsProperty<Color?>('color', color));
    properties.add(DiagnosticsProperty<Color?>('backgroundColor', backgroundColor));
    properties.add(DiagnosticsProperty<double>('width', width));
    properties.add(DiagnosticsProperty<double>('offset', offset));
    properties.add(DiagnosticsProperty<bool>('rounded', rounded));
  }
}
