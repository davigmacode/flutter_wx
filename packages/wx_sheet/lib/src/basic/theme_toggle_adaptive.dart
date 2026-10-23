import 'theme_toggle.dart';
import 'theme_toggle_m2.dart';
import 'theme_toggle_m3.dart';
import 'theme_toggle_ios.dart';

class WxSheetThemeToggleAdaptive extends WxSheetThemeToggle {
  WxSheetThemeToggleAdaptive(
    super.context, {
    super.animated,
    super.curve,
    super.duration,
  });

  @override
  get baseTheme {
    if (isIOS) {
      return WxSheetThemeToggleIOS(context);
    } else if (useMaterial3) {
      return WxSheetThemeToggleM3(context);
    }
    return WxSheetThemeToggleM2(context);
  }
}
