import 'dart:async';
import 'package:flutter/foundation.dart';
import 'model.dart';

class ChronoGraph extends ValueNotifier<Chrono> {
  final ChronoLevel level;
  final Duration interval;
  final Duration duration; // Duration.zero => count-up
  final void Function()? onCompleted;
  final bool? autostart; // null/true => auto start, false => manual

  static const defaultLevel = ChronoLevel.seconds;
  static const defaultInterval = Duration(seconds: 1);
  static const defaultAutostart = true;

  late final Stopwatch _stopwatch;
  Timer? _timer;

  bool get _isCountDown => duration != Duration.zero;

  ChronoGraph({
    ChronoLevel? level,
    Duration? interval,
    DateTime? date,
    this.onCompleted,
    this.autostart,
  }) : assert(
         date == null || date.isAfter(DateTime.now()),
         'Date must be in the future',
       ),
       level = level ?? defaultLevel,
       interval = interval ?? defaultInterval,
       duration =
           date != null ? date.difference(DateTime.now()) : Duration.zero,
       super(
         date != null
             ? Chrono.fromDuration(
               date.difference(DateTime.now()),
               level: level,
             )
             : Chrono.zero,
       ) {
    _stopwatch = Stopwatch();
    if (autostart != false) start();
  }

  ChronoGraph.stopwatch({
    ChronoLevel? level,
    Duration? interval,
    this.onCompleted,
    this.autostart,
  }) : level = level ?? defaultLevel,
       interval = interval ?? defaultInterval,
       duration = Duration.zero,
       super(Chrono.zero) {
    _stopwatch = Stopwatch();
    if (autostart != false) start();
  }

  ChronoGraph.countdown({
    ChronoLevel? level,
    Duration? interval,
    required DateTime date,
    this.onCompleted,
    this.autostart,
  }) : assert(date.isAfter(DateTime.now()), 'Date must be in the future'),
       level = level ?? defaultLevel,
       interval = interval ?? defaultInterval,
       duration = date.difference(DateTime.now()),
       super(
         Chrono.fromDuration(date.difference(DateTime.now()), level: level),
       ) {
    _stopwatch = Stopwatch();
    if (autostart != false) start();
  }

  ChronoGraph.timer({
    ChronoLevel? level,
    Duration? interval,
    required this.duration,
    this.onCompleted,
    this.autostart,
  }) : level = level ?? defaultLevel,
       interval = interval ?? defaultInterval,
       super(Chrono.fromDuration(duration, level: level)) {
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
      value = Chrono.fromDuration(
        duration,
        running: false,
        completed: false,
        level: level,
      );
    } else {
      // Reset count-up to 0
      value = Chrono.zero;
    }
  }

  void _tick() {
    if (_isCountDown) {
      final remaining = duration - _stopwatch.elapsed;
      if (remaining <= Duration.zero) {
        // Completed
        _stopwatch.stop();
        _timer?.cancel();
        value = Chrono.fromDuration(
          Duration.zero,
          running: false,
          completed: true,
          level: level,
        );
        onCompleted?.call();
        return;
      }
      final chrono = Chrono.fromDuration(
        remaining,
        running: _stopwatch.isRunning,
        completed: false,
        level: level,
      );
      if (chrono != value) value = chrono;
    } else {
      // Count-up
      final elapsed = _stopwatch.elapsed;
      final chrono = Chrono.fromDuration(
        elapsed,
        running: _stopwatch.isRunning,
        completed: false,
        level: level,
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

  @override
  void dispose() {
    _timer?.cancel();
    _stopwatch.stop();
    super.dispose();
  }
}
