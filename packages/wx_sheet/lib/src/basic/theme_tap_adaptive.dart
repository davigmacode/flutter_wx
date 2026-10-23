import 'theme_tap.dart';
import 'theme_tap_m2.dart';
import 'theme_tap_m3.dart';
import 'theme_tap_ios.dart';

class WxSheetThemeTapAdaptive extends WxSheetThemeTap {
  WxSheetThemeTapAdaptive(
    super.context, {
    super.animated,
    super.curve,
    super.duration,
  });

  @override
  get baseTheme {
    if (isIOS) {
      return WxSheetThemeTapIOS(context);
    } else if (useMaterial3) {
      return WxSheetThemeTapM3(context);
    }
    return WxSheetThemeTapM2(context);
  }
}
