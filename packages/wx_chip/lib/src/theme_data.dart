import 'package:wx_sheet/wx_event.dart';
import 'package:wx_sheet/wx_sheet.dart';
import 'style.dart';

class WxChipThemeData extends WxSheetThemeData<WxChipThemeData> {
  /// Whether to display a leading checkmark before the chip content.
  final bool leadingCheckmark;

  /// Whether to display a trailing checkmark after the chip content.
  final bool trailingCheckmark;

  @override
  get leading => leadingCheckmark ? const DrivenCheckmark() : super.leading;

  @override
  get trailing => trailingCheckmark ? const DrivenCheckmark() : super.trailing;

  /// Creates a theme data that can be used for [WxChipTheme].
  const WxChipThemeData({
    super.curve,
    super.duration,
    super.variant,
    super.size,
    super.severity,
    WxChipStyle super.style = const WxChipStyle(),
    WxSheetStyleResolver<WxChipStyle>? super.styleResolver,
    super.overlay,
    super.feedback,
    super.focusable,
    super.disabled,
    super.inherits,
    super.mouseCursor,
    super.leading,
    super.trailing,
    this.leadingCheckmark = false,
    this.trailingCheckmark = false,
  }) : super(animated: true);

  WxChipThemeData.from([
    WxChipThemeData? super.other,
    WxChipThemeData super.fallback = const WxChipThemeData(),
  ])  : leadingCheckmark = other?.leadingCheckmark ?? fallback.leadingCheckmark,
        trailingCheckmark =
            other?.trailingCheckmark ?? fallback.trailingCheckmark,
        super.from();

  WxChipThemeData.fromAncestor(
    WxSheetThemeData<WxChipThemeData>? other, {
    WxChipThemeData fallback = const WxChipThemeData(),
    bool? leadingSpinner,
    bool? trailingSpinner,
  })  : leadingCheckmark = leadingSpinner ?? fallback.leadingCheckmark,
        trailingCheckmark = trailingSpinner ?? fallback.trailingCheckmark,
        super.from(other, fallback);

  @override
  WxChipThemeData copyWith({
    animated,
    curve,
    duration,
    variant,
    size,
    severity,
    style,
    styleResolver,
    overlay,
    feedback,
    focusable,
    disabled,
    inherits,
    mouseCursor,
    leading,
    trailing,
    bool? leadingCheckmark,
    bool? trailingCheckmark,
  }) {
    final ancestor = super.copyWith(
      animated: animated,
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
      inherits: inherits,
      mouseCursor: mouseCursor,
      leading: leading,
      trailing: trailing,
    );
    return WxChipThemeData.fromAncestor(
      ancestor,
      leadingSpinner: leadingCheckmark,
      trailingSpinner: trailingCheckmark,
    );
  }

  @override
  WxChipThemeData merge(other) {
    // if null return current object
    if (other == null) return this;

    final ancestor = super.merge(other);
    return WxChipThemeData.fromAncestor(ancestor);
  }
}
