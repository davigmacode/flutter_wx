import 'package:flutter/widgets.dart';
import 'package:widget_event/widget_event.dart';

/// A widget that displays different child widgets based on events.
///
/// The `DrivenChild` class allows you to define different child widgets for
/// various event states (e.g., enabled, error, disabled, loading, etc.) and
/// conditionally display the appropriate widget based on the current events.
class DrivenChild<T extends Widget?> extends StatelessWidget
    implements DrivenProperty<T> {
  /// Creates a `DrivenChild` with the provided `enabled` widget and optional
  /// widgets for various event states.
  const DrivenChild(
    this.atEnabled, {
    this.atError,
    this.atDisabled,
    this.atLoading,
    this.atDragged,
    this.atPressed,
    this.atHovered,
    this.atFocused,
    this.atIndeterminate,
    this.atSelected,
    this.registry = const {},
    super.key,
  });

  /// Creates a `DrivenChild` with the provided `enabled` widget for all states.
  const DrivenChild.all(this.atEnabled, {super.key})
      : atError = null,
        atDisabled = null,
        atLoading = null,
        atDragged = null,
        atPressed = null,
        atHovered = null,
        atFocused = null,
        atIndeterminate = null,
        atSelected = null,
        registry = const {};

  /// Creates a `DrivenChild` with the provided `enabled` widget
  /// and a map of custom event-widget associations.
  const DrivenChild.map(this.atEnabled, this.registry, {super.key})
      : atError = null,
        atDisabled = null,
        atLoading = null,
        atDragged = null,
        atPressed = null,
        atHovered = null,
        atFocused = null,
        atIndeterminate = null,
        atSelected = null;

  /// Creates a `DrivenChild` with a callback function.
  factory DrivenChild.by(DrivenPropertyResolver<T> callback) {
    return DrivenChildResolver<T>(callback);
  }

  /// The widget to display when the widget is enabled.
  final T atEnabled;

  /// The widget to display when the `WidgetEvent.error` event occurs.
  final T? atError;

  /// The widget to display when the `WidgetEvent.disabled` event occurs.
  final T? atDisabled;

  /// The widget to display when the `WidgetEvent.loading` event occurs.
  final T? atLoading;

  /// The widget to display when the `WidgetEvent.dragged` event occurs.
  final T? atDragged;

  /// The widget to display when the `WidgetEvent.pressed` event occurs.
  final T? atPressed;

  /// The widget to display when the `WidgetEvent.hovered` event occurs.
  final T? atHovered;

  /// The widget to display when the `WidgetEvent.focused` event occurs.
  final T? atFocused;

  /// The widget to display when the `WidgetEvent.indeterminate` event occurs.
  final T? atIndeterminate;

  /// The widget to display when the `WidgetEvent.selected` event occurs.
  final T? atSelected;

  /// A map of custom event-widget associations.
  final Map<WidgetEvent, T?> registry;

  /// Combines the default and custom event-to-widget mappings.
  Map<WidgetEvent, T?> get driven => {
        WidgetEvent.error: atError,
        WidgetEvent.disabled: atDisabled,
        WidgetEvent.loading: atLoading,
        WidgetEvent.dragged: atDragged,
        WidgetEvent.pressed: atPressed,
        WidgetEvent.hovered: atHovered,
        WidgetEvent.focused: atFocused,
        WidgetEvent.indeterminate: atIndeterminate,
        WidgetEvent.selected: atSelected,
      }..addAll(registry);

  @override
  T resolve(Set<WidgetEvent> events) {
    T result = atEnabled;
    if (driven.isNotEmpty) {
      for (final e in driven.entries) {
        if (events.contains(e.key)) {
          result = _resolveSingle(e.value, result);
          break;
        }
      }
    }
    return result;
  }

  T _resolveSingle(T? child, T fallback) {
    if (child != null) return child;
    return fallback;
  }

  /// Evaluates a given value based on the provided events.
  static T evaluate<T extends Widget?>(T value, Set<WidgetEvent> events) {
    return DrivenProperty.evaluate<T>(value, events);
  }

  @override
  Widget build(BuildContext context) {
    return resolve({}) ?? const SizedBox();
  }
}

/// A `DrivenChild` that determines the child widget using a resolver function.
class DrivenChildResolver<T extends Widget?> extends DrivenChild<T> {
  /// Creates a `DrivenChildResolver` from a provided resolver function.
  DrivenChildResolver(this.resolver, {super.key}) : super(resolver({}));

  /// The resolver function that determines the child widget based on events.
  final DrivenPropertyResolver<T> resolver;

  @override
  T resolve(Set<WidgetEvent> events) => resolver(events);

  /// Evaluates a given value based on the provided events.
  static T evaluate<T extends Widget?>(T value, Set<WidgetEvent> events) {
    return DrivenProperty.evaluate<T>(value, events);
  }
}
