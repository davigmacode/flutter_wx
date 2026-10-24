import 'package:wx_sheet/wx_event.dart';
import 'package:wx_sheet/wx_sheet.dart';
import 'style_driven.dart';
import 'style.dart';
import 'theme.dart';
import 'theme_data.dart';

/// The `WxChip` widget serves as the building block for many Widgetarian components,
/// providing a base layer for customization with a chip-like appearance.
class WxChip extends WxSheet<WxChipThemeData> {
  /// Whether to display a leading checkmark before the chip content.
  final bool? leadingCheckmark;

  /// Whether to display a trailing checkmark after the chip content.
  final bool? trailingCheckmark;

  /// Creates a chip widget.
  ///
  /// Inherits all the properties from the base class [WxSheet].
  const WxChip({
    super.key,
    super.animated,
    super.duration,
    super.curve,
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
    super.overlay,
    super.overlayColor,
    super.overlayOpacity,
    super.overlayShape,
    super.overlayExtent,
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
    super.focusedStyle,
    super.hoveredStyle,
    super.pressedStyle,
    super.loadingStyle,
    super.disabledStyle,
    super.selectedStyle,
    super.indeterminateStyle,
    super.style,
    super.tooltip,
    super.selected,
    super.indeterminate,
    super.disabled,
    super.loading,
    super.autofocus,
    super.focusNode,
    super.onPressed,
    super.onSelected,
    super.leading,
    super.trailing,
    this.leadingCheckmark,
    this.trailingCheckmark,
    super.child,
  });

  @override
  WxChipStyle get effectiveStyle {
    return const WxDrivenChipStyle().merge(super.effectiveStyle);
  }

  @override
  WxChipThemeData getTheme(context) {
    return WxChipTheme.of(context);
  }

  @override
  WxChipStyle getInheritedStyle(context, inherits) {
    if (inherits) {
      final parentStyle = getParentStyle(context);
      return const WxDrivenChipStyle().merge(parentStyle).merge(effectiveStyle);
    }
    return effectiveStyle;
  }

  /// Returns a `DrivenCheckmark` if `leadingCheckmark` is true,
  /// `DrivenChild.all(null)` if `leadingCheckmark` is false,
  /// otherwise returns the default leading content.
  @override
  get leading => leadingCheckmark == true
      ? const DrivenCheckmark()
      : leadingCheckmark == false
          ? const DrivenChild.all(null)
          : super.leading;

  /// Returns a `DrivenCheckmark` if `trailingCheckmark` is true,
  /// `DrivenChild.all(null)` if `trailingCheckmark` is false,
  /// otherwise returns the default trailing content.
  @override
  get trailing => trailingCheckmark == true
      ? const DrivenCheckmark()
      : trailingCheckmark == false
          ? const DrivenChild.all(null)
          : super.trailing;
}
