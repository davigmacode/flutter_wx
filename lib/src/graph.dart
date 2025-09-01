import 'dart:async';
import 'package:flutter/foundation.dart';
import 'model.dart';

class ChronoGraph extends ValueNotifier<Chrono> {
  final ChronoLevel level;
  final Duration interval;
  final Duration duration; // Duration.zero => count-up
  final void Function()? onCompleted;
  final bool? autostart; // null/true => auto start, false => manual

  late final Stopwatch _stopwatch;
  Timer? _timer;

  bool get _isCountDown => duration != Duration.zero;

  ChronoGraph({
    this.level = ChronoLevel.seconds,
    this.interval = const Duration(seconds: 1),
    DateTime? date,
    this.onCompleted,
    this.autostart,
  }) : assert(
         date == null || date.isAfter(DateTime.now()),
         'Date must be in the future',
       ),
       duration =
           date != null ? date.difference(DateTime.now()) : Duration.zero,
       super(Chrono.initial) {
    _stopwatch = Stopwatch();
    if (autostart != false) start();
  }

  ChronoGraph.timer({
    this.level = ChronoLevel.seconds,
    this.interval = const Duration(seconds: 1),
    required this.duration,
    this.onCompleted,
    this.autostart,
  }) : super(Chrono.initial) {
    _stopwatch = Stopwatch();
    if (autostart != false) start();
  }

  void start() {
    if (_stopwatch.isRunning) return;
    _stopwatch.start();
    _tick(); // update immediately so the UI doesn't wait one interval
    _timer = Timer.periodic(interval, (_) => _tick());
  }

  void pause() {
    if (!_stopwatch.isRunning) return;
    _stopwatch.stop();
    _timer?.cancel();
    _updateFlags(running: false);
  }

  void reset() {
    _stopwatch.reset();
    _timer?.cancel();
    if (_isCountDown) {
      // Return to the initial countdown time
      value = _toChrono(duration, running: false, completed: false);
    } else {
      // Reset count-up to 0
      value = Chrono.initial;
    }
  }

  void _tick() {
    if (_isCountDown) {
      final remaining = duration - _stopwatch.elapsed;
      if (remaining <= Duration.zero) {
        // Completed
        _stopwatch.stop();
        _timer?.cancel();
        value = _toChrono(Duration.zero, running: false, completed: true);
        onCompleted?.call();
        return;
      }
      final chrono = _toChrono(
        remaining,
        running: _stopwatch.isRunning,
        completed: false,
      );
      if (chrono != value) value = chrono;
    } else {
      // Count-up
      final elapsed = _stopwatch.elapsed;
      final chrono = _toChrono(
        elapsed,
        running: _stopwatch.isRunning,
        completed: false,
      );
      if (chrono != value) value = chrono;
    }
  }

  void _updateFlags({bool? running, bool? completed}) {
    value = Chrono(
      days: value.days,
      hours: value.hours,
      minutes: value.minutes,
      seconds: value.seconds,
      running: running ?? value.running,
      completed: completed ?? value.completed,
      level: level,
    );
  }

  Chrono _toChrono(
    Duration d, {
    required bool running,
    required bool completed,
  }) {
    int totalSeconds = d.inSeconds;
    int days = totalSeconds ~/ 86400;
    int hours = (totalSeconds % 86400) ~/ 3600;
    int minutes = (totalSeconds % 3600) ~/ 60;
    int seconds = totalSeconds % 60;

    // Fold units according to the requested level
    switch (level) {
      case ChronoLevel.days:
        hours += days * 24;
        days = 0;
      // continue
      case ChronoLevel.hours:
        minutes += hours * 60;
        hours = 0;
      // continue
      case ChronoLevel.minutes:
        seconds += minutes * 60;
        minutes = 0;
      // continue
      case ChronoLevel.seconds:
        break;
    }

    return Chrono(
      days: days,
      hours: hours,
      minutes: minutes,
      seconds: seconds,
      running: running,
      completed: completed,
      level: level,
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _stopwatch.stop();
    super.dispose();
  }
}
