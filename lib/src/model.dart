/// Granularity level for representing a duration.
///
/// The level determines how larger units are folded down to the selected level
/// when converting a [Duration] into a [Chrono]. Examples:
/// - [ChronoLevel.days]: no folding; keep days/hours/minutes/seconds as-is.
/// - [ChronoLevel.hours]: fold days → hours; keep minutes/seconds.
/// - [ChronoLevel.minutes]: fold days and hours → minutes; keep seconds.
/// - [ChronoLevel.seconds]: fold everything → seconds.
enum ChronoLevel { days, hours, minutes, seconds }

/// Execution direction of a chronograph.
///
/// - [forward]: count up (stopwatch behavior).
/// - [reverse]: count down (timer/countdown behavior).
enum ChronoMode {
  forward,
  reverse;

  /// Whether this mode represents a countdown (reverse).
  bool get isReverse => this == ChronoMode.reverse;

  /// Whether this mode represents a stopwatch (forward).
  bool get isForward => this == ChronoMode.forward;
}

/// Immutable snapshot of a time breakdown for stopwatch/timer displays.
///
/// A [Chrono] represents a split form of a duration into days, hours, minutes
/// and seconds with additional flags to indicate whether the source is
/// currently running or already completed. It is designed to be used as the
/// value type for [ValueListenable]s such as [ChronoGraph].
class Chrono {
  /// Creates a [Chrono] value.
  ///
  /// - [days], [hours], [minutes], [seconds]: components of the time value.
  /// - [running]: whether the source stopwatch/timer is currently running.
  /// - [completed]: whether a countdown has finished.
  /// - [level]: the granularity at which units are folded.
  const Chrono({
    this.days = 0,
    this.hours = 0,
    this.minutes = 0,
    this.seconds = 0,
    this.running = false,
    this.completed = false,
    this.level = ChronoLevel.days,
  });

  /// Convenient initial value for a zeroed, idle state.
  static const zero = Chrono();

  /// Builds a [Chrono] from a [Duration].
  ///
  /// - [running] and [completed] control the flags on the result.
  /// - [level] sets how units are folded (e.g., minutes fold seconds).
  factory Chrono.fromDuration(
    Duration d, {
    bool? running,
    bool? completed,
    ChronoLevel? level,
  }) {
    int totalSeconds = d.inSeconds;
    int days = totalSeconds ~/ 86400;
    int hours = (totalSeconds % 86400) ~/ 3600;
    int minutes = (totalSeconds % 3600) ~/ 60;
    int seconds = totalSeconds % 60;

    // Fold larger units down to the selected display level.
    // Example: level=minutes -> fold days and hours into minutes (keep seconds).
    level ??= ChronoLevel.days;
    switch (level) {
      case ChronoLevel.days:
        // Keep days as the largest unit; no folding needed.
        break;
      case ChronoLevel.hours:
        // Fold days into hours; keep minutes and seconds as-is.
        hours += days * 24;
        days = 0;
        break;
      case ChronoLevel.minutes:
        // Fold days and hours into minutes; keep seconds as-is.
        minutes += days * 24 * 60 + hours * 60;
        days = 0;
        hours = 0;
        break;
      case ChronoLevel.seconds:
        // Fold everything down into seconds.
        seconds += days * 24 * 3600 + hours * 3600 + minutes * 60;
        days = 0;
        hours = 0;
        minutes = 0;
        break;
    }

    return Chrono(
      days: days,
      hours: hours,
      minutes: minutes,
      seconds: seconds,
      running: running ?? false,
      completed: completed ?? false,
      level: level,
    );
  }

  /// Day component of the time value.
  final int days;

  /// Hour component of the time value.
  final int hours;

  /// Minute component of the time value.
  final int minutes;

  /// Second component of the time value.
  final int seconds;

  /// Whether the source stopwatch/timer is currently running.
  final bool running;

  /// Whether a countdown has reached completion (i.e., hit zero).
  final bool completed;

  /// The granularity level used to compute this breakdown.
  final ChronoLevel level;

  /// Two-digit padded day string.
  String get paddedDays => days.toString().padLeft(2, '0');

  /// Two-digit padded hour string.
  String get paddedHours => hours.toString().padLeft(2, '0');

  /// Two-digit padded minute string.
  String get paddedMinutes => minutes.toString().padLeft(2, '0');

  /// Two-digit padded second string.
  String get paddedSeconds => seconds.toString().padLeft(2, '0');

  /// Total whole days represented by this value.
  int get inDays => days;

  /// Total whole hours represented by this value.
  int get inHours => days * 24 + hours;

  /// Total whole minutes represented by this value.
  int get inMinutes => inHours * 60 + minutes;

  /// Total whole seconds represented by this value.
  int get inSeconds => inMinutes * 60 + seconds;

  @override
  /// Equality based on all fields.
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Chrono &&
          days == other.days &&
          hours == other.hours &&
          minutes == other.minutes &&
          seconds == other.seconds &&
          running == other.running &&
          completed == other.completed &&
          level == other.level;

  @override
  /// Hash code combining all fields.
  int get hashCode =>
      Object.hash(days, hours, minutes, seconds, running, completed, level);
}
