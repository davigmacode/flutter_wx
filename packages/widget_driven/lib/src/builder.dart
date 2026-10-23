import 'package:flutter/widgets.dart';
import 'package:widget_event/widget_event.dart';

/// Signature for a builder that builds a widget based on the current set of [WidgetEvent]s.
typedef DrivenWidgetBuilder = Widget Function(
  BuildContext context,
  Set<WidgetEvent> events,
  Widget? child,
);

/// A widget that listens to a [WidgetEventController] and rebuilds whenever
/// its active [WidgetEvent]s change.
class DrivenBuilder extends StatelessWidget {
  /// Creates a [DrivenBuilder].
  const DrivenBuilder({
    super.key,
    required this.controller,
    required this.builder,
    this.child,
  });

  /// The controller whose events determine the build output.
  final WidgetEventController controller;

  /// The builder called whenever the controller's events change.
  final DrivenWidgetBuilder builder;

  /// An optional child widget that is independent of the events and passed
  /// back into the [builder].
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) => builder(context, controller.value, child),
      child: child,
    );
  }
}
