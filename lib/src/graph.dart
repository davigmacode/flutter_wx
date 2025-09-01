import 'dart:async';
import 'package:flutter/foundation.dart';
import 'model.dart';

/// Reactive graph/engine that drives stopwatch and countdown timers.
///
/// Exposes a [ValueListenable] of [Chrono] that widgets can listen to for
/// updates. It supports three main modes via factory constructors:
/// - [ChronoGraph.stopwatch]: counts up from zero.
/// - [ChronoGraph.timer]: counts down a fixed [Duration].
/// - [ChronoGraph.countdown]: counts down to a target [DateTime].
///
/// Use [start], [pause], and [reset] to control the progression.
class ChronoGraph extends ValueNotifier<Chrono> {
  /// Display granularity used when building [Chrono] values.
  final ChronoLevel level;

  /// Tick frequency for periodic updates.
  final Duration interval;

  /// Countdown length; [Duration.zero] indicates a stopwatch (count-up).
  final Duration duration;

  /// Callback invoked once when a countdown reaches zero.
  final void Function()? onCompleted;

  /// Whether to automatically start on creation; `null/true` = auto, `false` = manual.
  final bool? autostart;

  /// Default [level] when not specified.
  static const defaultLevel = ChronoLevel.days;

  /// Default [interval] when not specified.
  static const defaultInterval = Duration(seconds: 1);

  /// Default autostart behavior.
  static const defaultAutostart = true;

  late final Stopwatch _stopwatch;
  Timer? _timer;

  /// Whether this instance is running a countdown (as opposed to a stopwatch).
  bool get _isCountDown => duration != Duration.zero;

  /// Private constructor shared by all public factories.
  ChronoGraph._internal({
    ChronoLevel? level,
    Duration? interval,
    required this.duration,
    required Chrono initialValue,
    this.onCompleted,
    this.autostart,
  }) : level = level ?? defaultLevel,
       interval = interval ?? defaultInterval,
       super(initialValue) {
    _stopwatch = Stopwatch();
    if (autostart != false) start();
  }

  /// Stopwatch: counts up from zero.
  ///
  /// - [level]: output granularity for emitted [Chrono] values.
  /// - [interval]: tick frequency for UI updates.
  /// - [onCompleted]: unused for stopwatch, but accepted for symmetry.
  /// - [autostart]: start immediately unless set to `false`.
  factory ChronoGraph.stopwatch({
    ChronoLevel? level,
    Duration? interval,
    void Function()? onCompleted,
    bool? autostart,
  }) {
    return ChronoGraph._internal(
      level: level,
      interval: interval,
      duration: Duration.zero,
      initialValue: Chrono.zero,
      onCompleted: onCompleted,
      autostart: autostart,
    );
  }

  /// Countdown to a specific target [DateTime].
  ///
  /// Asserts that [date] is in the future.
  factory ChronoGraph.countdown({
    ChronoLevel? level,
    Duration? interval,
    required DateTime date,
    void Function()? onCompleted,
    bool? autostart,
  }) {
    assert(date.isAfter(DateTime.now()), 'Date must be in the future');
    final d = date.difference(DateTime.now());
    return ChronoGraph._internal(
      level: level,
      interval: interval,
      duration: d,
      initialValue: Chrono.fromDuration(d, level: level),
      onCompleted: onCompleted,
      autostart: autostart,
    );
  }

  /// Timer: counts down a fixed [duration].
  factory ChronoGraph.timer({
    ChronoLevel? level,
    Duration? interval,
    required Duration duration,
    void Function()? onCompleted,
    bool? autostart,
  }) {
    return ChronoGraph._internal(
      level: level,
      interval: interval,
      duration: duration,
      initialValue: Chrono.fromDuration(duration, level: level),
      onCompleted: onCompleted,
      autostart: autostart,
    );
  }

  /// Convenience constructor: `date != null` → countdown, else stopwatch.
  factory ChronoGraph({
    ChronoLevel? level,
    Duration? interval,
    DateTime? date,
    void Function()? onCompleted,
    bool? autostart,
  }) {
    if (date != null) {
      return ChronoGraph.countdown(
        level: level,
        interval: interval,
        date: date,
        onCompleted: onCompleted,
        autostart: autostart,
      );
    } else {
      return ChronoGraph.stopwatch(
        level: level,
        interval: interval,
        onCompleted: onCompleted,
        autostart: autostart,
      );
    }
  }

  /// Starts the underlying stopwatch and begins emitting ticks.
  ///
  /// No-ops if already running.
  void start() {
    if (_stopwatch.isRunning) return;
    _stopwatch.start();
    // Push an immediate update so the UI reflects the start without delay.
    _tick();
    _timer = Timer.periodic(interval, (_) => _tick());
  }

  /// Pauses the progression and stops ticking.
  ///
  /// No-ops if already paused.
  void pause() {
    if (!_stopwatch.isRunning) return;
    _stopwatch.stop();
    _timer?.cancel();
    _updateFlags(running: false);
  }

  /// Resets to the initial value and cancels active ticks.
  ///
  /// - Countdown: returns to the original countdown length.
  /// - Stopwatch: returns to zero.
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

  /// Updates only the flags, preserving numeric components and level.
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
  /// Cancels timers and stops the internal stopwatch.
  void dispose() {
    _timer?.cancel();
    _stopwatch.stop();
    super.dispose();
  }
}
