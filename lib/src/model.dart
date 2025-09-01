enum ChronoLevel { days, hours, minutes, seconds }

class Chrono {
  const Chrono({
    this.days = 0,
    this.hours = 0,
    this.minutes = 0,
    this.seconds = 0,
    this.running = false,
    this.completed = false,
    this.level = ChronoLevel.seconds,
  });

  static const zero = Chrono();

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

  final int days, hours, minutes, seconds;
  final bool running, completed;
  final ChronoLevel level;

  String get paddedDays => days.toString().padLeft(2, '0');
  String get paddedHours => hours.toString().padLeft(2, '0');
  String get paddedMinutes => minutes.toString().padLeft(2, '0');
  String get paddedSeconds => seconds.toString().padLeft(2, '0');

  int get inDays => days;
  int get inHours => days * 24 + hours;
  int get inMinutes => inHours * 60 + minutes;
  int get inSeconds => inMinutes * 60 + seconds;

  @override
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
  int get hashCode =>
      Object.hash(days, hours, minutes, seconds, running, completed, level);
}
