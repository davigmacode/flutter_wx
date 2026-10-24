import 'package:flutter/widgets.dart';
import 'package:wx_sheet/wx_sheet.dart';
import 'style.dart';
import 'theme_data.dart';
import 'style_driven.dart';
import 'types.dart';

abstract class WxChipThemePreset extends WxChipThemeData
    with WxSheetThemePreset<WxChipThemeData> {
  @protected
  WxChipThemePreset(
    this.context, {
    super.curve,
    super.duration,
  });

  @override
  final BuildContext context;

  @override
  WxSheetVariant? get variant => WxChipVariant.tonal;

  @override
  WxChipStyle get style => WxChipStyle.fromAncestor(super.style);

  @override
  WxDrivenChipStyle baseStyle(data) {
    return const WxDrivenChipStyle(
      adaptiveSpacing: true,
    );
  }
}

class WxChipThemeAdaptive extends WxChipThemePreset {
  WxChipThemeAdaptive(
    super.context, {
    super.curve,
    super.duration,
  });

  WxChipThemePreset get platformTheme {
    if (isIOS) {
      return WxChipThemeIOS(context);
    } else if (useMaterial3) {
      return WxChipThemeM3(context);
    }
    return WxChipThemeM2(context);
  }

  @override
  get baseTheme => platformTheme.baseTheme;

  @override
  get effectiveStyle => platformTheme.effectiveStyle;

  @override
  get styleResolver => platformTheme.styleResolver;
}

class WxChipThemeM2 extends WxChipThemePreset {
  WxChipThemeM2(
    super.context, {
    super.curve,
    super.duration,
  });

  @override
  get baseTheme => WxSheetThemeToggleM2(context);

  @override
  baseStyle(data) {
    return super.baseStyle(data).copyWith(
          minHeight: 32.0,
          padding: EdgeInsets.only(
            left: data.hasLeading ? 8 : 12,
            right: data.hasTrailing ? 8 : 12,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          textStyle: textTheme.bodyLarge,
          checkmarkWeight: 2,
          iconSize: 18.0,
          spacing: 8,
        );
  }
}

class WxChipThemeM3 extends WxChipThemePreset {
  WxChipThemeM3(
    super.context, {
    super.curve,
    super.duration,
  });

  @override
  get baseTheme => WxSheetThemeToggleM3(context);

  @override
  baseStyle(data) {
    return super.baseStyle(data).copyWith(
          minHeight: 32.0,
          padding: EdgeInsets.only(
            left: data.hasLeading ? 8 : 16,
            right: data.hasTrailing ? 8 : 16,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          textStyle: textTheme.labelLarge,
          checkmarkWeight: 2,
          iconSize: 18.0,
          spacing: 8,
        );
  }
}

class WxChipThemeIOS extends WxChipThemePreset {
  WxChipThemeIOS(
    super.context, {
    super.curve,
    super.duration,
  });

  @override
  get baseTheme => WxSheetThemeToggleIOS(context);

  @override
  baseStyle(data) {
    return super.baseStyle(data).copyWith(
          minHeight: 32.0,
          padding: EdgeInsets.only(
            left: data.hasLeading ? 8 : 16,
            right: data.hasTrailing ? 8 : 16,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          textStyle: textTheme.bodyLarge,
          checkmarkWeight: 2,
          iconSize: 18.0,
          spacing: 8,
        );
  }
}
