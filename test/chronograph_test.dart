// ignore_for_file: avoid_print

import 'package:flutter_test/flutter_test.dart';
import 'package:chronograph/chronograph.dart';

void main() {
  test('ChronoGraph should count up correctly', () async {
    final graph = ChronoGraph();
    final values = <Chrono>[];

    graph.addListener(() {
      values.add(graph.value);
      print('⏳ Count Up: ${graph.value.inSeconds}');
    });

    graph.start();
    await Future.delayed(const Duration(seconds: 4));

    expect(
      values.last.inSeconds,
      greaterThanOrEqualTo(3),
      reason: 'Timer did not reach 3',
    );

    graph.dispose();
  });

  test('ChronoGraph should complete when countdown reaches zero', () async {
    final graph = ChronoGraph.timer(duration: const Duration(seconds: 5));
    final values = <Chrono>[];

    graph.addListener(() {
      values.add(graph.value);
      print(
        '⏳ Count Down: ${graph.value.inSeconds}, completed: ${graph.value.completed}',
      );
    });

    graph.start();
    await Future.delayed(const Duration(seconds: 6));

    expect(values.last.inSeconds, equals(0), reason: 'Timer did not reach 0');
    expect(
      values.last.completed,
      isTrue,
      reason: 'Timer was not marked as completed',
    );

    graph.dispose();
  });
}
