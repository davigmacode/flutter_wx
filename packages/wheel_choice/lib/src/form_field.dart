import 'package:flutter/material.dart';
import 'controller.dart';
import 'effect.dart';
import 'header.dart';
import 'item.dart';
import 'picker.dart';

/// A [FormField] that contains a [WheelChoice].
///
/// This widget integrates [WheelChoice] with Flutter's [Form] architecture,
/// providing automatic validation, error message rendering, [onSaved],
/// and form reset support.
///
/// Usage:
/// ```dart
/// WheelChoiceFormField<String>(
///   options: const ['Red', 'Green', 'Blue'],
///   initialValue: 'Red',
///   decoration: const InputDecoration(
///     labelText: 'Favorite Color',
///     border: OutlineInputBorder(),
///   ),
///   validator: (value) {
///     if (value == null || value.isEmpty) {
///       return 'Please choose a color';
///     }
///     return null;
///   },
///   onSaved: (value) => _savedColor = value,
/// )
/// ```
///
/// Null Handling in Forms:
/// - When a selection is mandatory, set `initialValue: null`. The form field
///   tracks `null` until the user actively interacts with the wheel.
/// - A [validator] checking `value == null` will block form submission if the
///   field is left untouched:
///   ```dart
///   validator: (v) => v == null ? 'Please make a selection' : null,
///   ```
class WheelChoiceFormField<T> extends FormField<T> {
  /// Creates a [FormField] containing a [WheelChoice].
  WheelChoiceFormField({
    super.key,
    this.controller,
    List<T>? options,
    T? initialValue,
    ValueChanged<T?>? onChanged,
    ValueChanged<int>? onIndexChanged,
    WheelItemDisable<T>? itemDisabled,
    WheelItemLabel<T>? itemLabel,
    WheelItemBuilder<T>? itemBuilder,
    int? itemVisible,
    double? itemExtent,
    WheelHeader? header,
    WidgetBuilder? overlay,
    WheelEffect? effect,
    ScrollPhysics? physics,
    Clip? clipBehavior,
    bool? loop,
    Duration? animationDuration,
    Curve? animationCurve,
    bool? keyboard,
    FocusNode? focusNode,
    bool? haptics,
    bool? expanded,
    Axis? scrollDirection,
    InputDecoration? decoration,
    super.onSaved,
    super.validator,
    super.autovalidateMode,
    super.enabled = true,
    super.restorationId,
  }) : super(
          initialValue: controller != null ? controller.value : initialValue,
          builder: (FormFieldState<T> field) {
            final effectiveDecoration = (decoration ?? const InputDecoration())
                .applyDefaults(Theme.of(field.context).inputDecorationTheme);

            void handleChanged(T? value) {
              field.didChange(value);
              onChanged?.call(value);
            }

            final effectivePhysics =
                enabled ? physics : const NeverScrollableScrollPhysics();

            Widget wheel;
            if (controller != null) {
              wheel = WheelChoice<T>.raw(
                controller: controller,
                itemLabel: itemLabel,
                itemBuilder: itemBuilder,
                itemVisible: itemVisible,
                itemExtent: itemExtent,
                header: header,
                overlay: overlay,
                effect: effect,
                physics: effectivePhysics,
                clipBehavior: clipBehavior,
                keyboard: enabled ? keyboard : false,
                focusNode: focusNode,
                haptics: enabled ? haptics : false,
                expanded: expanded,
                scrollDirection: scrollDirection,
              );
            } else {
              wheel = WheelChoice<T>(
                options: options,
                value: field.value,
                onChanged: enabled ? handleChanged : null,
                onIndexChanged: onIndexChanged,
                itemDisabled: itemDisabled,
                itemLabel: itemLabel,
                itemBuilder: itemBuilder,
                itemVisible: itemVisible,
                itemExtent: itemExtent,
                header: header,
                overlay: overlay,
                effect: effect,
                physics: effectivePhysics,
                clipBehavior: clipBehavior,
                loop: loop,
                animationDuration: animationDuration,
                animationCurve: animationCurve,
                keyboard: enabled ? keyboard : false,
                focusNode: focusNode,
                haptics: enabled ? haptics : false,
                expanded: expanded,
                scrollDirection: scrollDirection,
              );
            }

            return InputDecorator(
              decoration: effectiveDecoration.copyWith(
                errorText: field.errorText,
                enabled: enabled,
              ),
              isEmpty: field.value == null,
              child: wheel,
            );
          },
        );

  /// Optional external controller for the wheel picker.
  final WheelController<T>? controller;

  @override
  FormFieldState<T> createState() => _WheelChoiceFormFieldState<T>();
}

class _WheelChoiceFormFieldState<T> extends FormFieldState<T> {
  @override
  WheelChoiceFormField<T> get widget => super.widget as WheelChoiceFormField<T>;

  @override
  void initState() {
    super.initState();
    widget.controller?.valueListenable.addListener(_handleControllerChanged);
  }

  @override
  void didUpdateWidget(WheelChoiceFormField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?.valueListenable
          .removeListener(_handleControllerChanged);
      widget.controller?.valueListenable.addListener(_handleControllerChanged);
      if (widget.controller != null) {
        setValue(widget.controller!.value);
      }
    }
  }

  @override
  void dispose() {
    widget.controller?.valueListenable.removeListener(_handleControllerChanged);
    super.dispose();
  }

  void _handleControllerChanged() {
    if (widget.controller != null && widget.controller!.value != value) {
      didChange(widget.controller!.value);
    }
  }

  @override
  void reset() {
    super.reset();
    if (widget.controller != null) {
      if (widget.initialValue != null) {
        widget.controller!.setValue(widget.initialValue as T);
      }
    }
  }
}
