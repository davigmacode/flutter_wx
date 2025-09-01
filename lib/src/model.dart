/// Granularity level for representing a duration.
///
/// The level determines how smaller units are folded into larger ones when
/// converting a [Duration] into a [Chrono]. For example, when using
/// [ChronoLevel.minutes], seconds are folded into minutes.
enum ChronoLevel { days, hours, minutes, seconds }

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
    this.level = ChronoLevel.seconds,
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

    // Fold units according to the requested level
    level ??= ChronoLevel.seconds;
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
