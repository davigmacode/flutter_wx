import 'package:wx_sheet/wx_event.dart';
import 'package:wx_sheet/wx_sheet.dart';

/// Interactive events that [WxChip] can take on
/// when receiving input from the user.
class WxChipEvent extends WxSheetEvent {
  const WxChipEvent(super.value);

  /// The state when the user drags their mouse cursor over the given widget.
  static const hovered = WxChipEvent('hovered');

  /// The state when the user navigates with the keyboard to a given widget.
  ///
  /// This can also sometimes be triggered when a widget is tapped. For example,
  /// when a [TextField] is tapped, it becomes [focused].
  static const focused = WxChipEvent('focused');

  /// The state when the user is actively pressing down on the given widget.
  static const pressed = WxChipEvent('pressed');

  /// The state when the user is actively pressing down on the given widget.
  static const loading = WxChipEvent('loading');

  /// The state when this widget is disabled and cannot be interacted with.
  ///
  /// Disabled widgets should not respond to hover, focus, press, or drag
  /// interactions.
  static const disabled = WxChipEvent('disabled');

  /// Checker for whether events considers [WxChipEvent.hovered] to be active.
  static bool isHovered(Set<WidgetEvent> events) {
    return events.contains(hovered);
  }

  /// Checker for whether events considers [WxChipEvent.focused] to be active.
  static bool isFocused(Set<WidgetEvent> events) {
    return events.contains(focused);
  }

  /// Checker for whether events considers [WxChipEvent.pressed] to be active.
  static bool isPressed(Set<WidgetEvent> events) {
    return events.contains(pressed);
  }

  /// Checker for whether events considers [WxChipEvent.loading] to be active.
  static bool isLoading(Set<WidgetEvent> events) {
    return events.contains(loading);
  }

  /// Checker for whether events considers [WxChipEvent.disabled] to be active.
  static bool isDisabled(Set<WidgetEvent> events) {
    return events.contains(disabled);
  }
}
