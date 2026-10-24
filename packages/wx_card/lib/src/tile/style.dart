import 'package:wx_sheet/wx_event.dart';
import 'package:wx_sheet/wx_sheet.dart';

class WxCardTileStyle extends WxSheetStyle {
  /// Create a raw [WxCardTileStyle].
  const WxCardTileStyle({
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

  /// Create a [WxCardTileStyle] from another style
  WxCardTileStyle.from(super.other) : super.from();

  /// Create a [WxCardTileStyle] from another [WxSheetStyle].
  WxCardTileStyle.fromAncestor(super.other) : super.from();

  /// Creates a copy of this [WxCardTileStyle] but with
  /// the given fields replaced with the new values.
  @override
  WxCardTileStyle copyWith({
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
    return WxCardTileStyle.fromAncestor(ancestor);
  }

  /// Resolves the value for the given set of events
  /// if `value` is an event driven [WxCardTileStyle],
  /// otherwise returns the value itself.
  static WxCardTileStyle evaluate(
    WxCardTileStyle? value,
    Set<WidgetEvent> events,
  ) {
    return DrivenProperty.evaluate<WxCardTileStyle?>(value, events) ??
        const WxCardTileStyle();
  }

  /// Create a driven [WxCardTileStyle] from a resolver callback.
  static WxCardTileStyle resolveWith(
    DrivenPropertyResolver<WxCardTileStyle?> resolver,
  ) {
    return WxCardTileStyleDrivenBy(resolver);
  }

  /// Create a driven [WxCardTileStyle] with event-specific overrides.
  static WxCardTileStyle driven({
    WxCardTileStyle? base,
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
        : WxCardTileStyle.fromAncestor(style);
  }

  @override
  WxCardTileStyle resolve(Set<WidgetEvent> events) {
    if (!isDriven) return this;
    final resolved = super.resolve(events);
    return WxCardTileStyle.fromAncestor(resolved);
  }

  @override
  WxCardTileStyle merge(WxSheetStyle? other) {
    if (other == null) return this;
    if (isDriven || other.isDriven) {
      return WxMergedDrivenCardTileStyle(this, other);
    }
    return mergeStatic(other);
  }

  @override
  WxCardTileStyle mergeStatic(WxSheetStyle? other) {
    if (other == null) return this;
    final ancestor = super.mergeStatic(other);
    return WxCardTileStyle.fromAncestor(ancestor);
  }

  /// Linearly interpolate between two [WxCardTileStyle] objects.
  static WxCardTileStyle? lerp(
      WxCardTileStyle? a, WxCardTileStyle? b, double t) {
    final ancestor = WxSheetStyle.lerp(a, b, t);
    return WxCardTileStyle.fromAncestor(ancestor);
  }
}

/// Internal driven card tile style resolved dynamically via a callback.
class WxCardTileStyleDrivenBy extends WxCardTileStyle {
  WxCardTileStyleDrivenBy(this._resolver)
      : super.fromAncestor(_resolver(const <WidgetEvent>{}));

  final DrivenPropertyResolver<WxCardTileStyle?> _resolver;

  @override
  bool get isDriven => true;

  @override
  WxCardTileStyle resolve(Set<WidgetEvent> events) {
    final resolved = _resolver(events);
    return resolved ?? const WxCardTileStyle();
  }
}

/// Internal driven card tile style representing a combination of two styles,
/// at least one of which is dynamic/event-driven.
class WxMergedDrivenCardTileStyle extends WxCardTileStyle {
  WxMergedDrivenCardTileStyle(this._a, this._b)
      : super.fromAncestor(_a
            .resolve(const <WidgetEvent>{})
            .mergeStatic(_b?.resolve(const <WidgetEvent>{})));

  final WxCardTileStyle _a;
  final WxSheetStyle? _b;

  @override
  bool get isDriven => true;

  @override
  WxCardTileStyle resolve(Set<WidgetEvent> events) {
    if (events.isEmpty) return this;
    final resolvedA = _a.resolve(events);
    final resolvedB = _b?.resolve(events);
    return resolvedA.mergeStatic(resolvedB);
  }
}
