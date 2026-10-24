import 'package:flutter/foundation.dart';
import 'package:wx_sheet/wx_event.dart';
import 'package:wx_sheet/wx_sheet.dart';
import 'style.dart';

/// Create a [WxChipStyle] when some events occurs
class WxDrivenChipStyle extends WxChipStyle
    with WxDrivenSheetProperty<WxChipStyle> {
  final DrivenPropertyResolver<WxChipStyle?>? _resolver;

  @override
  bool get isDriven => true;

  @override
  final bool? inherits;

  @override
  final WxChipStyle? focusedStyle;

  @override
  final WxChipStyle? hoveredStyle;

  @override
  final WxChipStyle? pressedStyle;

  @override
  final WxChipStyle? loadingStyle;

  @override
  final WxChipStyle? disabledStyle;

  @override
  final WxChipStyle? selectedStyle;

  @override
  final WxChipStyle? indeterminateStyle;

  /// Create a raw [WxDrivenChipStyle].
  const WxDrivenChipStyle({
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
    super.checkmarkColor,
    super.checkmarkSize,
    super.checkmarkWeight,
    this.focusedStyle,
    this.hoveredStyle,
    this.pressedStyle,
    this.loadingStyle,
    this.disabledStyle,
    this.selectedStyle,
    this.indeterminateStyle,
    this.inherits,
  }) : _resolver = null;

  /// Create a [WxDrivenChipStyle] with value
  /// from another [WxChipStyle].
  WxDrivenChipStyle.fromAncestor(
    super.enabled, {
    this.focusedStyle,
    this.hoveredStyle,
    this.pressedStyle,
    this.loadingStyle,
    this.disabledStyle,
    this.selectedStyle,
    this.indeterminateStyle,
    this.inherits,
  })  : _resolver = null,
        super.from();

  /// Create a [WxDrivenChipStyle] with value
  /// from another [WxDrivenChipStyle].
  WxDrivenChipStyle.from(WxDrivenChipStyle? super.other)
      : _resolver = other?._resolver,
        focusedStyle = other?.focusedStyle,
        hoveredStyle = other?.hoveredStyle,
        pressedStyle = other?.pressedStyle,
        loadingStyle = other?.loadingStyle,
        disabledStyle = other?.disabledStyle,
        selectedStyle = other?.selectedStyle,
        indeterminateStyle = other?.indeterminateStyle,
        inherits = other?.inherits,
        super.from();

  /// Create a [WxDrivenChipStyle] from a resolver callback
  WxDrivenChipStyle.resolver(
    WxDrivenSheetStyleResolver<WxChipStyle?> resolver, {
    this.inherits = false,
  })  : _resolver = resolver,
        focusedStyle = resolver({WxSheetEvent.focused}),
        hoveredStyle = resolver({WxSheetEvent.hovered}),
        pressedStyle = resolver({WxSheetEvent.pressed}),
        loadingStyle = resolver({WxSheetEvent.loading}),
        disabledStyle = resolver({WxSheetEvent.disabled}),
        selectedStyle = resolver({WxSheetEvent.selected}),
        indeterminateStyle = resolver({WxSheetEvent.indeterminate}),
        super.fromAncestor(resolver({}));

  /// Resolves the value for the given set of events
  /// if `value` is an event driven [WxChipStyle],
  /// otherwise returns the value itself.
  static WxChipStyle evaluate(
    WxChipStyle? value,
    Set<WidgetEvent> events,
  ) {
    return DrivenProperty.evaluate<WxChipStyle?>(value, events) ??
        const WxChipStyle();
  }

  @override
  WxChipStyle resolve(Set<WidgetEvent> events) {
    if (_resolver != null) {
      final evaluated = _resolver(events);
      if (evaluated != null) {
        return inherits != false ? mergeStatic(evaluated) : evaluated;
      }
    }
    return super.resolve(events);
  }

  @override
  WxChipStyle resolveInherits(WxChipStyle accumulator, WxChipStyle? style) {
    return inherits != false
        ? accumulator.mergeStatic(style)
        : WxChipStyle.from(style);
  }

  /// Creates a copy of this [WxDrivenChipStyle] but with
  /// the given fields replaced with the new values.
  @override
  WxDrivenChipStyle copyWith({
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
    spinnerColor,
    spinnerBackgroundColor,
    spinnerSize,
    spinnerWidth,
    spinnerRounded,
    checkmarkColor,
    checkmarkSize,
    checkmarkWeight,
    checkmarkRounded,
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
    bool? inherits,
    WxChipStyle? focusedStyle,
    WxChipStyle? hoveredStyle,
    WxChipStyle? pressedStyle,
    WxChipStyle? loadingStyle,
    WxChipStyle? disabledStyle,
    WxChipStyle? selectedStyle,
    WxChipStyle? indeterminateStyle,
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
    return WxDrivenChipStyle.fromAncestor(
      ancestor,
      inherits: inherits ?? this.inherits,
      focusedStyle: this.focusedStyle?.merge(focusedStyle) ?? focusedStyle,
      hoveredStyle: this.hoveredStyle?.merge(hoveredStyle) ?? hoveredStyle,
      pressedStyle: this.pressedStyle?.merge(pressedStyle) ?? pressedStyle,
      loadingStyle: this.loadingStyle?.merge(loadingStyle) ?? loadingStyle,
      disabledStyle: this.disabledStyle?.merge(disabledStyle) ?? disabledStyle,
      selectedStyle: this.selectedStyle?.merge(selectedStyle) ?? selectedStyle,
      indeterminateStyle: this.indeterminateStyle?.merge(indeterminateStyle) ??
          indeterminateStyle,
    );
  }

  @override
  WxChipStyle merge(other) {
    if (other == null) return this;
    return WxMergedDrivenChipStyle(this, other);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    super.debugFillDrivenStyle(properties);
  }
}

/// Internal driven chip style representing a combination of two styles,
/// at least one of which is dynamic/event-driven.
class WxMergedDrivenChipStyle extends WxChipStyle {
  WxMergedDrivenChipStyle(this._a, this._b)
      : super.fromAncestor(_a
            .resolve(const <WidgetEvent>{})
            .mergeStatic(_b?.resolve(const <WidgetEvent>{})));

  final WxChipStyle _a;
  final WxSheetStyle? _b;

  @override
  bool get isDriven => true;

  @override
  WxChipStyle resolve(Set<WidgetEvent> events) {
    if (events.isEmpty) return this;
    final resolvedA = _a.resolve(events);
    final resolvedB = _b?.resolve(events);
    return resolvedA.mergeStatic(resolvedB);
  }
}
