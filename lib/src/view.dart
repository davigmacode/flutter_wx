import 'package:flutter/widgets.dart';
import 'model.dart';
import 'graph.dart';

typedef ChronoBuilder = Widget Function(Chrono info);

class ChronoView extends StatelessWidget {
  final ChronoGraph controller;
  final ChronoBuilder builder;

  const ChronoView({
    super.key,
    required this.controller,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Chrono>(
      stream: controller.stream,
      initialData: Chrono(),
      builder: (context, snapshot) {
        return builder(snapshot.data!);
      },
    );
  }
}
