import 'package:wx_sheet/wx_event.dart';
import 'package:wx_sheet/wx_sheet.dart';
import 'style_driven.dart';

class WxButtonStyle extends WxSheetStyle {
  /// Create a raw [WxButtonStyle].
  const WxButtonStyle({
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
    super.spinnerColor,
    super.spinnerBackgroundColor,
    super.spinnerSize,
    super.spinnerWidth,
    super.spinnerRounded,
    super.titleStyle,
    super.subtitleStyle,
    super.titleSize,
    super.subtitleSize,
    super.titleColor,
    super.subtitleColor,
    super.titleMaxLines,
    super.subtitleMaxLines,
    super.titleWeight,
    super.subtitleWeight,
  });

  /// Create a [WxButtonStyle] from another [WxButtonStyle]
  WxButtonStyle.from(WxButtonStyle? super.other) : super.from();

  /// Create a [WxButtonStyle] from another [WxSheetStyle]
  WxButtonStyle.fromAncestor(super.other) : super.from();

  /// Creates a copy of this [WxButtonStyle] but with
  /// the given fields replaced with the new values.
  @override
  WxButtonStyle copyWith({
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
    return WxButtonStyle.fromAncestor(ancestor);
  }

  /// Resolves the value for the given set of events
  /// if `value` is an event driven [WxButtonStyle],
  /// otherwise returns the value itself.
  static WxButtonStyle evaluate(
    WxButtonStyle? value,
    Set<WidgetEvent> events,
  ) {
    return DrivenProperty.evaluate<WxButtonStyle?>(value, events) ??
        const WxButtonStyle();
  }

  /// Create a driven [WxButtonStyle] from a resolver callback.
  static WxButtonStyle resolveWith(
    DrivenPropertyResolver<WxButtonStyle?> resolver,
  ) {
    return WxDrivenButtonStyle.resolver(resolver);
  }

  /// Create a driven [WxButtonStyle] with event-specific overrides.
  static WxButtonStyle driven({
    WxButtonStyle? base,
    WxButtonStyle? selected,
    WxButtonStyle? indeterminate,
    WxButtonStyle? focused,
    WxButtonStyle? hovered,
    WxButtonStyle? pressed,
    WxButtonStyle? loading,
    WxButtonStyle? disabled,
    bool? inherits,
  }) {
    final style = WxDrivenButtonStyle(
      inherits: inherits,
      selectedStyle: selected,
      indeterminateStyle: indeterminate,
      focusedStyle: focused,
      hoveredStyle: hovered,
      pressedStyle: pressed,
      loadingStyle: loading,
      disabledStyle: disabled,
    );
    return base != null ? base.merge(style) : style;
  }

  @override
  WxButtonStyle resolve(Set<WidgetEvent> events) {
    if (!isDriven) return this;
    final resolved = super.resolve(events);
    return WxButtonStyle.fromAncestor(resolved);
  }

  @override
  WxButtonStyle merge(WxSheetStyle? other) {
    if (other == null) return this;
    if (isDriven || other.isDriven) {
      return WxMergedDrivenButtonStyle(this, other);
    }
    return mergeStatic(other);
  }

  @override
  WxButtonStyle mergeStatic(WxSheetStyle? other) {
    if (other == null) return this;
    final ancestor = super.mergeStatic(other);
    return WxButtonStyle.fromAncestor(ancestor);
  }

  /// Linearly interpolate between two [WxButtonStyle] objects.
  static WxButtonStyle? lerp(WxButtonStyle? a, WxButtonStyle? b, double t) {
    final ancestor = WxSheetStyle.lerp(a, b, t);
    return WxButtonStyle.fromAncestor(ancestor);
  }
}
