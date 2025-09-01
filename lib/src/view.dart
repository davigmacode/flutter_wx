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

  /// Named constructor that obtains the graph from an ancestor [ChronoProvider].
  ///
  /// Usage:
  /// ```dart
  /// ChronoView.of(
  ///   context: context,
  ///   builder: (ctx, chrono, _) => Text(chrono.paddedSeconds),
  /// )
  /// ```
  factory ChronoView.of(
    BuildContext context, {
    Key? key,
    required ValueWidgetBuilder<Chrono> builder,
    Widget? child,
  }) {
    final graph = ChronoProvider.of(context);
    return ChronoView(key: key, graph: graph, builder: builder, child: child);
  }
}

/// Provides a [ChronoGraph] down the widget tree and manages its lifetime.
///
/// Wrap parts of your UI with [ChronoProvider] to make the same [ChronoGraph]
/// accessible and listenable to descendants. The provider owns the given
/// [graph] and calls `dispose()` when unmounted.
class ChronoProvider extends StatefulWidget {
  /// The chronograph instance to expose to descendants.
  final ChronoGraph graph;

  /// The subtree that can access the provided [graph].
  final Widget child;

  const ChronoProvider({
    super.key,
    required this.graph,
    required this.child,
  });

  /// Builder-style constructor similar to [ChronoView].
  ///
  /// Rebuilds when the underlying [graph] value changes.
  factory ChronoProvider.builder({
    Key? key,
    required ChronoGraph graph,
    required Widget Function(BuildContext, Chrono, Widget?) builder,
    Widget? child,
  }) {
    return ChronoProvider(
      key: key,
      graph: graph,
      child: ChronoView(graph: graph, builder: builder, child: child),
    );
  }

  /// Obtain the provided [ChronoGraph] from the nearest ancestor provider.
  static ChronoGraph of(BuildContext context) {
    final inherited = context
        .dependOnInheritedWidgetOfExactType<_ChronoInherited>();
    assert(inherited != null, 'No ChronoProvider found in context');
    return inherited!.graph;
  }

  @override
  State<ChronoProvider> createState() => _ChronoProviderState();
}

class _ChronoProviderState extends State<ChronoProvider> {
  @override
  void dispose() {
    // Manage the lifetime of the provided graph.
    widget.graph.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _ChronoInherited(
      graph: widget.graph,
      child: widget.child,
    );
  }
}

class _ChronoInherited extends InheritedNotifier<ChronoGraph> {
  const _ChronoInherited({
    required ChronoGraph graph,
    required super.child,
  }) : _graph = graph,
       super(notifier: graph);

  final ChronoGraph _graph;
  ChronoGraph get graph => _graph;
}
