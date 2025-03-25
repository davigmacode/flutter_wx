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
