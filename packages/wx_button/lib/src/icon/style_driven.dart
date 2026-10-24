import 'package:flutter/foundation.dart';
import 'package:wx_sheet/wx_event.dart';
import 'package:wx_sheet/wx_sheet.dart';
import 'style.dart';

/// Create a [WxIconButtonStyle] when some events occurs
class WxDrivenIconButtonStyle extends WxIconButtonStyle
    with WxDrivenSheetProperty<WxIconButtonStyle> {
  final DrivenPropertyResolver<WxIconButtonStyle?>? _resolver;

  @override
  bool get isDriven => true;

  @override
  final bool? inherits;

  @override
  final WxIconButtonStyle? selectedStyle;

  @override
  final WxIconButtonStyle? indeterminateStyle;

  @override
  final WxIconButtonStyle? focusedStyle;

  @override
  final WxIconButtonStyle? hoveredStyle;

  @override
  final WxIconButtonStyle? pressedStyle;

  @override
  final WxIconButtonStyle? loadingStyle;

  @override
  final WxIconButtonStyle? disabledStyle;

  /// Create a raw [WxDrivenIconButtonStyle].
  const WxDrivenIconButtonStyle({
    super.radius,
    super.minRadius,
    super.maxRadius,
    super.variant,
    super.size,
    super.severity,
    super.margin,
    super.padding,
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
    super.borderStyle,
    super.borderOffset,
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
    this.selectedStyle,
    this.indeterminateStyle,
    this.focusedStyle,
    this.hoveredStyle,
    this.pressedStyle,
    this.loadingStyle,
    this.disabledStyle,
    this.inherits,
  }) : _resolver = null;

  /// Create a [WxDrivenIconButtonStyle] with value
  /// from another [WxIconButtonStyle].
  WxDrivenIconButtonStyle.fromAncestor(
    super.enabled, {
    this.selectedStyle,
    this.indeterminateStyle,
    this.focusedStyle,
    this.hoveredStyle,
    this.pressedStyle,
    this.loadingStyle,
    this.disabledStyle,
    this.inherits,
  })  : _resolver = null,
        super.from();

  /// Create a [WxDrivenIconButtonStyle] with value
  /// from another [WxDrivenIconButtonStyle].
  WxDrivenIconButtonStyle.from(WxDrivenIconButtonStyle? super.other)
      : _resolver = other?._resolver,
        selectedStyle = other?.selectedStyle,
        indeterminateStyle = other?.indeterminateStyle,
        focusedStyle = other?.focusedStyle,
        hoveredStyle = other?.hoveredStyle,
        pressedStyle = other?.pressedStyle,
        loadingStyle = other?.loadingStyle,
        disabledStyle = other?.disabledStyle,
        inherits = other?.inherits,
        super.from();

  /// Create a [WxDrivenIconButtonStyle] from a resolver callback
  WxDrivenIconButtonStyle.resolver(
    WxDrivenSheetStyleResolver<WxIconButtonStyle?> resolver, {
    this.inherits = false,
  })  : _resolver = resolver,
        selectedStyle = resolver({WxSheetEvent.selected}),
        indeterminateStyle = resolver({WxSheetEvent.indeterminate}),
        focusedStyle = resolver({WxSheetEvent.focused}),
        hoveredStyle = resolver({WxSheetEvent.hovered}),
        pressedStyle = resolver({WxSheetEvent.pressed}),
        loadingStyle = resolver({WxSheetEvent.loading}),
        disabledStyle = resolver({WxSheetEvent.disabled}),
        super.fromAncestor(resolver({}));

  /// Resolves the value for the given set of events
  /// if `value` is an event driven [WxIconButtonStyle],
  /// otherwise returns the value itself.
  static WxIconButtonStyle evaluate(
    WxIconButtonStyle? value,
    Set<WidgetEvent> events,
  ) {
    return DrivenProperty.evaluate<WxIconButtonStyle?>(value, events) ??
        const WxIconButtonStyle();
  }

  @override
  WxIconButtonStyle resolve(Set<WidgetEvent> events) {
    if (_resolver != null) {
      final evaluated = _resolver(events);
      if (evaluated != null) {
        return inherits != false ? mergeStatic(evaluated) : evaluated;
      }
    }
    return super.resolve(events);
  }

  @override
  WxIconButtonStyle resolveInherits(
      WxIconButtonStyle accumulator, WxIconButtonStyle? style) {
    return inherits != false
        ? accumulator.mergeStatic(style)
        : (style != null
            ? WxIconButtonStyle.fromAncestor(style)
            : accumulator);
  }

  /// Creates a copy of this [WxDrivenIconButtonStyle] but with
  /// the given fields replaced with the new values.
  @override
  WxDrivenIconButtonStyle copyWith({
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
    bool? inherits,
    WxIconButtonStyle? focusedStyle,
    WxIconButtonStyle? hoveredStyle,
    WxIconButtonStyle? pressedStyle,
    WxIconButtonStyle? loadingStyle,
    WxIconButtonStyle? disabledStyle,
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
    return WxDrivenIconButtonStyle.fromAncestor(
      ancestor,
      inherits: inherits ?? this.inherits,
      focusedStyle: this.focusedStyle?.merge(focusedStyle) ?? focusedStyle,
      hoveredStyle: this.hoveredStyle?.merge(hoveredStyle) ?? hoveredStyle,
      pressedStyle: this.pressedStyle?.merge(pressedStyle) ?? pressedStyle,
      loadingStyle: this.loadingStyle?.merge(loadingStyle) ?? loadingStyle,
      disabledStyle: this.disabledStyle?.merge(disabledStyle) ?? disabledStyle,
    );
  }

  @override
  WxIconButtonStyle merge(other) {
    if (other == null) return this;
    return WxMergedDrivenIconButtonStyle(this, other);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    super.debugFillDrivenStyle(properties);
  }
}

/// Internal driven icon button style representing a combination of two styles,
/// at least one of which is dynamic/event-driven.
class WxMergedDrivenIconButtonStyle extends WxIconButtonStyle {
  WxMergedDrivenIconButtonStyle(this._a, this._b)
      : super.fromAncestor(_a
            .resolve(const <WidgetEvent>{})
            .mergeStatic(_b?.resolve(const <WidgetEvent>{})));

  final WxIconButtonStyle _a;
  final WxSheetStyle? _b;

  @override
  bool get isDriven => true;

  @override
  WxIconButtonStyle resolve(Set<WidgetEvent> events) {
    if (events.isEmpty) return this;
    final resolvedA = _a.resolve(events);
    final resolvedB = _b?.resolve(events);
    return resolvedA.mergeStatic(resolvedB);
  }
}
