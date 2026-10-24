import 'package:wx_sheet/wx_event.dart';
import 'package:wx_sheet/wx_sheet.dart';

class WxCardStyle extends WxSheetStyle {
  /// Create a raw [WxCardStyle].
  const WxCardStyle({
    super.variant,
    super.size,
    super.severity,
    super.width,
    super.height,
    super.minWidth,
    super.maxWidth,
    super.minHeight,
    super.maxHeight,
    super.margin,
    super.padding,
    super.spacing,
    super.adaptiveSpacing,
    super.offset,
    super.scale,
    super.rotate,
    super.flipX,
    super.flipY,
    super.opacity,
    super.alignment,
    super.clipBehavior,
    super.overlayColor,
    super.overlayOpacity,
    super.overlayShape,
    super.overlayExtent,
    super.surfaceTint,
    super.elevationColor,
    super.elevation,
    super.tileAlign,
    super.tileJustify,
    super.tileWrap,
    super.textStyle,
    super.textAlign,
    super.textSpacing,
    super.textColor,
    super.textOverflow,
    super.textSoftWrap,
    super.textWidthBasis,
    super.adaptiveForegroundColor,
    super.foregroundColor,
    super.foregroundOpacity,
    super.foregroundAlpha,
    super.backgroundColor,
    super.backgroundOpacity,
    super.backgroundAlpha,
    super.borderColor,
    super.borderOpacity,
    super.borderAlpha,
    super.borderWidth,
    super.borderRadius,
    super.borderStyle,
    super.borderOffset,
    super.border,
    super.image,
    super.shadows,
    super.gradient,
    super.iconColor,
    super.iconOpacity,
    super.iconSize,
    super.checkmarkColor,
    super.checkmarkSize,
    super.checkmarkWeight,
    super.checkmarkRounded,
    super.spinnerColor,
    super.spinnerBackgroundColor,
    super.spinnerSize,
    super.spinnerWidth,
    super.spinnerRounded,
  });

  /// Create a [WxCardStyle] from another style
  WxCardStyle.from(super.other) : super.from();

  /// Create a [WxCardStyle] from another [WxSheetStyle].
  WxCardStyle.fromAncestor(super.other) : super.from();

  /// Creates a copy of this [WxCardStyle] but with
  /// the given fields replaced with the new values.
  @override
  WxCardStyle copyWith({
    direction,
    variant,
    size,
    severity,
    width,
    height,
    minWidth,
    maxWidth,
    minHeight,
    maxHeight,
    margin,
    padding,
    spacing,
    adaptiveSpacing,
    offset,
    scale,
    rotate,
    flipX,
    flipY,
    opacity,
    alignment,
    clipBehavior,
    overlayColor,
    overlayOpacity,
    overlayShape,
    overlayExtent,
    surfaceTint,
    elevationColor,
    elevation,
    tileAlign,
    tileJustify,
    tileWrap,
    textStyle,
    textAlign,
    textSpacing,
    textColor,
    textOverflow,
    textSoftWrap,
    textWidthBasis,
    adaptiveForegroundColor,
    foregroundColor,
    foregroundOpacity,
    foregroundAlpha,
    backgroundColor,
    backgroundOpacity,
    backgroundAlpha,
    borderColor,
    borderOpacity,
    borderAlpha,
    borderWidth,
    borderRadius,
    borderStyle,
    borderOffset,
    border,
    image,
    shadows,
    gradient,
    iconColor,
    iconOpacity,
    iconSize,
    checkmarkColor,
    checkmarkSize,
    checkmarkWeight,
    checkmarkRounded,
    spinnerColor,
    spinnerBackgroundColor,
    spinnerSize,
    spinnerWidth,
    spinnerRounded,
    titleStyle,
    subtitleStyle,
    titleSize,
    subtitleSize,
    titleColor,
    subtitleColor,
    titleMaxLines,
    subtitleMaxLines,
    titleWeight,
    subtitleWeight,
  }) {
    final ancestor = super.copyWith(
      direction: direction,
      variant: variant,
      size: size,
      severity: severity,
      width: width,
      height: height,
      minWidth: minWidth,
      maxWidth: maxWidth,
      minHeight: minHeight,
      maxHeight: maxHeight,
      margin: margin,
      padding: padding,
      spacing: spacing,
      adaptiveSpacing: adaptiveSpacing,
      offset: offset,
      scale: scale,
      rotate: rotate,
      flipX: flipX,
      flipY: flipY,
      opacity: opacity,
      alignment: alignment,
      clipBehavior: clipBehavior,
      overlayColor: overlayColor,
      overlayOpacity: overlayOpacity,
      overlayShape: overlayShape,
      overlayExtent: overlayExtent,
      surfaceTint: surfaceTint,
      elevationColor: elevationColor,
      elevation: elevation,
      tileAlign: tileAlign,
      tileJustify: tileJustify,
      tileWrap: tileWrap,
      textStyle: textStyle,
      textAlign: textAlign,
      textSpacing: textSpacing,
      textColor: textColor,
      textOverflow: textOverflow,
      textSoftWrap: textSoftWrap,
      textWidthBasis: textWidthBasis,
      adaptiveForegroundColor: adaptiveForegroundColor,
      foregroundColor: foregroundColor,
      foregroundOpacity: foregroundOpacity,
      foregroundAlpha: foregroundAlpha,
      backgroundColor: backgroundColor,
      backgroundOpacity: backgroundOpacity,
      backgroundAlpha: backgroundAlpha,
      borderColor: borderColor,
      borderOpacity: borderOpacity,
      borderAlpha: borderAlpha,
      borderWidth: borderWidth,
      borderRadius: borderRadius,
      borderStyle: borderStyle,
      borderOffset: borderOffset,
      border: border,
      image: image,
      shadows: shadows,
      gradient: gradient,
      iconColor: iconColor,
      iconOpacity: iconOpacity,
      iconSize: iconSize,
      checkmarkColor: checkmarkColor,
      checkmarkSize: checkmarkSize,
      checkmarkWeight: checkmarkWeight,
      checkmarkRounded: checkmarkRounded,
      spinnerColor: spinnerColor,
      spinnerBackgroundColor: spinnerBackgroundColor,
      spinnerSize: spinnerSize,
      spinnerWidth: spinnerWidth,
      spinnerRounded: spinnerRounded,
      titleStyle: titleStyle,
      subtitleStyle: subtitleStyle,
      titleSize: titleSize,
      subtitleSize: subtitleSize,
      titleColor: titleColor,
      subtitleColor: subtitleColor,
      titleMaxLines: titleMaxLines,
      subtitleMaxLines: subtitleMaxLines,
      titleWeight: titleWeight,
      subtitleWeight: subtitleWeight,
    );
    return WxCardStyle.fromAncestor(ancestor);
  }

  /// Resolves the value for the given set of events
  /// if `value` is an event driven [WxCardStyle],
  /// otherwise returns the value itself.
  static WxCardStyle evaluate(
    WxCardStyle? value,
    Set<WidgetEvent> events,
  ) {
    return DrivenProperty.evaluate<WxCardStyle?>(value, events) ??
        const WxCardStyle();
  }

  /// Create a driven [WxCardStyle] from a resolver callback.
  static WxCardStyle resolveWith(
    DrivenPropertyResolver<WxCardStyle?> resolver,
  ) {
    return WxCardStyleDrivenBy(resolver);
  }

  /// Create a driven [WxCardStyle] with event-specific overrides.
  static WxCardStyle driven({
    WxCardStyle? base,
    WxSheetStyle? selected,
    WxSheetStyle? indeterminate,
    WxSheetStyle? focused,
    WxSheetStyle? hovered,
    WxSheetStyle? pressed,
    WxSheetStyle? loading,
    WxSheetStyle? disabled,
    bool? inherits,
  }) {
    final style = WxDrivenSheetStyle(
      inherits: inherits,
      selectedStyle: selected,
      indeterminateStyle: indeterminate,
      focusedStyle: focused,
      hoveredStyle: hovered,
      pressedStyle: pressed,
      loadingStyle: loading,
      disabledStyle: disabled,
    );
    return base != null
        ? base.merge(style)
        : WxCardStyle.fromAncestor(style);
  }

  @override
  WxCardStyle resolve(Set<WidgetEvent> events) {
    if (!isDriven) return this;
    final resolved = super.resolve(events);
    return WxCardStyle.fromAncestor(resolved);
  }

  @override
  WxCardStyle merge(WxSheetStyle? other) {
    if (other == null) return this;
    if (isDriven || other.isDriven) {
      return WxMergedDrivenCardStyle(this, other);
    }
    return mergeStatic(other);
  }

  @override
  WxCardStyle mergeStatic(WxSheetStyle? other) {
    if (other == null) return this;
    final ancestor = super.mergeStatic(other);
    return WxCardStyle.fromAncestor(ancestor);
  }

  /// Linearly interpolate between two [WxCardStyle] objects.
  static WxCardStyle? lerp(WxCardStyle? a, WxCardStyle? b, double t) {
    final ancestor = WxSheetStyle.lerp(a, b, t);
    return WxCardStyle.fromAncestor(ancestor);
  }
}

/// Internal driven card style resolved dynamically via a callback.
class WxCardStyleDrivenBy extends WxCardStyle {
  WxCardStyleDrivenBy(this._resolver)
      : super.fromAncestor(_resolver(const <WidgetEvent>{}));

  final DrivenPropertyResolver<WxCardStyle?> _resolver;

  @override
  bool get isDriven => true;

  @override
  WxCardStyle resolve(Set<WidgetEvent> events) {
    final resolved = _resolver(events);
    return resolved ?? const WxCardStyle();
  }
}

/// Internal driven card style representing a combination of two styles,
/// at least one of which is dynamic/event-driven.
class WxMergedDrivenCardStyle extends WxCardStyle {
  WxMergedDrivenCardStyle(this._a, this._b)
      : super.fromAncestor(_a
            .resolve(const <WidgetEvent>{})
            .mergeStatic(_b?.resolve(const <WidgetEvent>{})));

  final WxCardStyle _a;
  final WxSheetStyle? _b;

  @override
  bool get isDriven => true;

  @override
  WxCardStyle resolve(Set<WidgetEvent> events) {
    if (events.isEmpty) return this;
    final resolvedA = _a.resolve(events);
    final resolvedB = _b?.resolve(events);
    return resolvedA.mergeStatic(resolvedB);
  }
}
