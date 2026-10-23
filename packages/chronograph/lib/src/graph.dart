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
/// Use [start], [pause], and [reset] to control the progression. Direction is
/// determined by [mode] (see [ChronoMode]).
class ChronoGraph extends ValueNotifier<Chrono> {
  /// Display granularity used when building [Chrono] values.
  final ChronoLevel level;

  /// Tick frequency for periodic updates.
  final Duration interval;

  /// Base duration associated with this graph.
  ///
  /// - For [ChronoMode.forward] (stopwatch) this is always [Duration.zero].
  /// - For [ChronoMode.reverse] (timer/countdown) this is the starting
  ///   countdown length. It may also be [Duration.zero] when a past/now
  ///   `countdown(date)` is created, in which case the initial value is
  ///   completed and auto-start is suppressed.
  final Duration duration;

  /// Mode indicating whether this graph runs forward (stopwatch) or reverse (countdown).
  final ChronoMode mode;

  /// Callback invoked once when a reverse countdown reaches zero.
  final VoidCallback? onCompleted;

  /// Callback invoked when [start] is called and the graph begins running.
  final ValueChanged<Chrono>? onStart;

  /// Callback invoked when [pause] is called and the graph stops running.
  final ValueChanged<Chrono>? onPause;

  /// Callback invoked when [reset] is called.
  final ValueChanged<Chrono>? onReset;

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

  /// Private constructor shared by all public factories.
  ChronoGraph._internal({
    ChronoLevel? level,
    Duration? interval,
    required this.duration,
    required this.mode,
    required Chrono initialValue,
    this.onCompleted,
    this.onStart,
    this.onPause,
    this.onReset,
    this.autostart,
  }) : level = level ?? defaultLevel,
       interval = interval ?? defaultInterval,
       super(initialValue) {
    _stopwatch = Stopwatch();
    if (autostart != false && initialValue.completed != true) start();
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
    VoidCallback? onCompleted,
    ValueChanged<Chrono>? onStart,
    ValueChanged<Chrono>? onPause,
    ValueChanged<Chrono>? onReset,
    bool? autostart,
  }) {
    return ChronoGraph._internal(
      level: level,
      interval: interval,
      duration: Duration.zero,
      mode: ChronoMode.forward,
      initialValue: Chrono.zero,
      onCompleted: onCompleted,
      onStart: onStart,
      onPause: onPause,
      onReset: onReset,
      autostart: autostart,
    );
  }

  /// Countdown to a specific target [DateTime].
  ///
  /// If [date] is in the past or now, initializes as completed at zero.
  factory ChronoGraph.countdown({
    ChronoLevel? level,
    Duration? interval,
    required DateTime date,
    VoidCallback? onCompleted,
    ValueChanged<Chrono>? onStart,
    ValueChanged<Chrono>? onPause,
    ValueChanged<Chrono>? onReset,
    bool? autostart,
  }) {
    final now = DateTime.now();
    final raw = date.difference(now);
    final d = raw.isNegative ? Duration.zero : raw;
    final initial = raw.isNegative
        ? Chrono.fromDuration(
            Duration.zero,
            running: false,
            completed: true,
            level: level,
          )
        : Chrono.fromDuration(d, level: level);
    return ChronoGraph._internal(
      level: level,
      interval: interval,
      duration: d,
      mode: ChronoMode.reverse,
      initialValue: initial,
      onCompleted: onCompleted,
      onStart: onStart,
      onPause: onPause,
      onReset: onReset,
      autostart: autostart,
    );
  }

  /// Timer: counts down a fixed [duration].
  factory ChronoGraph.timer({
    ChronoLevel? level,
    Duration? interval,
    required Duration duration,
    VoidCallback? onCompleted,
    ValueChanged<Chrono>? onStart,
    ValueChanged<Chrono>? onPause,
    ValueChanged<Chrono>? onReset,
    bool? autostart,
  }) {
    return ChronoGraph._internal(
      level: level,
      interval: interval,
      duration: duration,
      mode: ChronoMode.reverse,
      initialValue: Chrono.fromDuration(duration, level: level),
      onCompleted: onCompleted,
      onStart: onStart,
      onPause: onPause,
      onReset: onReset,
      autostart: autostart,
    );
  }

  /// Convenience constructor: `date != null` → countdown (reverse), else
  /// stopwatch (forward).
  factory ChronoGraph({
    ChronoLevel? level,
    Duration? interval,
    DateTime? date,
    VoidCallback? onCompleted,
    ValueChanged<Chrono>? onStart,
    ValueChanged<Chrono>? onPause,
    ValueChanged<Chrono>? onReset,
    bool? autostart,
  }) {
    if (date != null) {
      return ChronoGraph.countdown(
        level: level,
        interval: interval,
        date: date,
        onCompleted: onCompleted,
        onStart: onStart,
        onPause: onPause,
        onReset: onReset,
        autostart: autostart,
      );
    } else {
      return ChronoGraph.stopwatch(
        level: level,
        interval: interval,
        onCompleted: onCompleted,
        onStart: onStart,
        onPause: onPause,
        onReset: onReset,
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
    onStart?.call(value);
  }

  /// Pauses the progression and stops ticking.
  ///
  /// No-ops if already paused.
  void pause() {
    if (!_stopwatch.isRunning) return;
    _stopwatch.stop();
    _timer?.cancel();
    value = value.copyWith(running: false);
    onPause?.call(value);
  }

  /// Resets to the initial value and cancels active ticks.
  ///
  /// - Countdown: returns to the original countdown length.
  /// - Stopwatch: returns to zero.
  void reset() {
    _stopwatch.reset();
    if (mode.isReverse) {
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
    onReset?.call(value);
  }

  void _tick() {
    if (mode.isReverse) {
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

  @override
  /// Cancels timers and stops the internal stopwatch.
  void dispose() {
    _timer?.cancel();
    _stopwatch.stop();
    super.dispose();
  }
}
