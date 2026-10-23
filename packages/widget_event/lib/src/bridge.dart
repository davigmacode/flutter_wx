import 'package:flutter/widgets.dart';
import 'controller.dart';
import 'event.dart';
import 'property.dart';

/// Extension on [WidgetEvent] providing direct bidirectional mapping
/// to Flutter's native [WidgetState].
extension WidgetEventStateBridge on WidgetEvent {
  /// Converts this [WidgetEvent] to a native Flutter [WidgetState], if applicable.
  ///
  /// Returns `null` for custom events or events not present in [WidgetState]
  /// (e.g. [WidgetEvent.loading], [WidgetEvent.indeterminate]).
  WidgetState? toWidgetState() {
    switch (value) {
      case 'hovered':
        return WidgetState.hovered;
      case 'focused':
        return WidgetState.focused;
      case 'pressed':
        return WidgetState.pressed;
      case 'dragged':
        return WidgetState.dragged;
      case 'selected':
        return WidgetState.selected;
      case 'disabled':
        return WidgetState.disabled;
      case 'error':
        return WidgetState.error;
      case 'scrolledUnder':
        return WidgetState.scrolledUnder;
      default:
        return null;
    }
  }

  /// Creates a [WidgetEvent] from a native Flutter [WidgetState].
  static WidgetEvent fromWidgetState(WidgetState state) {
    switch (state) {
      case WidgetState.hovered:
        return WidgetEvent.hovered;
      case WidgetState.focused:
        return WidgetEvent.focused;
      case WidgetState.pressed:
        return WidgetEvent.pressed;
      case WidgetState.dragged:
        return WidgetEvent.dragged;
      case WidgetState.selected:
        return WidgetEvent.selected;
      case WidgetState.disabled:
        return WidgetEvent.disabled;
      case WidgetState.error:
        return WidgetEvent.error;
      case WidgetState.scrolledUnder:
        return const WidgetEvent('scrolledUnder');
    }
  }
}

/// Extension on Flutter's native [WidgetState] to convert to [WidgetEvent].
extension WidgetStateEventBridge on WidgetState {
  /// Converts this [WidgetState] to a [WidgetEvent].
  WidgetEvent toWidgetEvent() => WidgetEventStateBridge.fromWidgetState(this);
}

/// Extension on `Set<WidgetEvent>` for batch conversion to `Set<WidgetState>`.
extension WidgetEventsStateBridge on Set<WidgetEvent> {
  /// Maps active [WidgetEvent]s to their equivalent native [WidgetState]s,
  /// discarding non-representable events.
  Set<WidgetState> toWidgetStates() {
    final states = <WidgetState>{};
    for (final event in this) {
      final state = event.toWidgetState();
      if (state != null) {
        states.add(state);
      }
    }
    return states;
  }
}

/// Extension on `Set<WidgetState>` for batch conversion to `Set<WidgetEvent>`.
extension WidgetStatesEventsBridge on Set<WidgetState> {
  /// Maps active [WidgetState]s to their equivalent [WidgetEvent]s.
  Set<WidgetEvent> toWidgetEvents() {
    return map((state) => state.toWidgetEvent()).toSet();
  }
}

/// Two-way synchronizer and bridge between [WidgetEventController]
/// and Flutter's native [WidgetStatesController].
class WidgetEventStatesBridge {
  WidgetEventStatesBridge._();

  /// Creates a native [WidgetStatesController] that is bound in real-time
  /// to the provided [WidgetEventController].
  static WidgetStatesController toWidgetStatesController(WidgetEventController controller) {
    final statesController = WidgetStatesController(controller.value.toWidgetStates());
    bool isSyncing = false;

    void onEventChanged() {
      if (isSyncing) return;
      isSyncing = true;
      statesController.value = controller.value.toWidgetStates();
      isSyncing = false;
    }

    void onStateChanged() {
      if (isSyncing) return;
      isSyncing = true;
      // Preserve events that don't exist in WidgetState (like loading, indeterminate)
      final nonStateEvents = controller.value.where((e) => e.toWidgetState() == null);
      controller.replace({
        ...statesController.value.toWidgetEvents(),
        ...nonStateEvents,
      });
      isSyncing = false;
    }

    controller.addListener(onEventChanged);
    statesController.addListener(onStateChanged);
    return statesController;
  }

  /// Creates a [WidgetEventController] bound in real-time
  /// to an existing native Flutter [WidgetStatesController].
  static WidgetEventController fromWidgetStatesController(WidgetStatesController statesController) {
    final controller = WidgetEventController(statesController.value.toWidgetEvents());
    bool isSyncing = false;

    void onEventChanged() {
      if (isSyncing) return;
      isSyncing = true;
      statesController.value = controller.value.toWidgetStates();
      isSyncing = false;
    }

    void onStateChanged() {
      if (isSyncing) return;
      isSyncing = true;
      final nonStateEvents = controller.value.where((e) => e.toWidgetState() == null);
      controller.replace({
        ...statesController.value.toWidgetEvents(),
        ...nonStateEvents,
      });
      isSyncing = false;
    }

    controller.addListener(onEventChanged);
    statesController.addListener(onStateChanged);
    return controller;
  }
}

/// Extension on [DrivenProperty] allowing it to be used anywhere
/// a Flutter native [WidgetStateProperty] is expected.
extension DrivenPropertyStateBridge<T> on DrivenProperty<T> {
  /// Converts this [DrivenProperty] into a native Flutter [WidgetStateProperty].
  WidgetStateProperty<T> toWidgetStateProperty() {
    return _DrivenToWidgetStatePropertyAdapter<T>(this);
  }
}

class _DrivenToWidgetStatePropertyAdapter<T> implements WidgetStateProperty<T> {
  _DrivenToWidgetStatePropertyAdapter(this.property);

  final DrivenProperty<T> property;

  @override
  T resolve(Set<WidgetState> states) {
    return property.resolve(states.toWidgetEvents());
  }
}
