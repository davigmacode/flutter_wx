import 'package:flutter/widgets.dart';
import 'model.dart';
import 'graph.dart';

typedef ChronoBuilder = Widget Function(BuildContext context, Chrono info);

class ChronoView extends StatelessWidget {
  final ChronoGraph graph;
  final ChronoBuilder builder;

  const ChronoView({super.key, required this.graph, required this.builder});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Chrono>(
      stream: graph.stream,
      initialData: Chrono.initial,
      builder: (context, snapshot) {
        return builder(context, snapshot.data!);
      },
    );
  }
}
