import 'theme_static.dart';
import 'theme_static_m2.dart';
import 'theme_static_m3.dart';
import 'theme_static_ios.dart';

class WxSheetThemeStaticAdaptive extends WxSheetThemeStatic {
  WxSheetThemeStaticAdaptive(
    super.context, {
    super.animated,
    super.curve,
    super.duration,
  });

  @override
  get baseTheme {
    if (isIOS) {
      return WxSheetThemeStaticIOS(context);
    } else if (useMaterial3) {
      return WxSheetThemeStaticM3(context);
    }
    return WxSheetThemeStaticM2(context);
  }
}
