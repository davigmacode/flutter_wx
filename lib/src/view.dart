import 'package:flutter/widgets.dart';
import 'model.dart';
import 'graph.dart';

class ChronoView extends ValueListenableBuilder<Chrono> {
  const ChronoView({
    super.key,
    required ChronoGraph graph,
    required super.builder,
    super.child,
  }) : super(valueListenable: graph);
}
