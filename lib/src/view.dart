import 'package:flutter/widgets.dart';
import 'model.dart';
import 'graph.dart';

/// A simple [ValueListenableBuilder] specialized for [Chrono] values.
///
/// Listens to a [ChronoGraph] and rebuilds using the provided [builder]
/// whenever the underlying [Chrono] value changes.
class ChronoView extends ValueListenableBuilder<Chrono> {
  /// Creates a [ChronoView].
  ///
  /// - [graph]: the source of [Chrono] updates.
  /// - [builder]: builds UI using the latest [Chrono].
  /// - [child]: optional subtree that does not depend on [Chrono].
  const ChronoView({
    super.key,
    required ChronoGraph graph,
    required super.builder,
    super.child,
  }) : super(valueListenable: graph);
}
