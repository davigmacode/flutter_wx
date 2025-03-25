enum ChronoLevel { days, hours, minutes, seconds }

class Chrono {
  final int days, hours, minutes, seconds;
  final bool completed;

  Chrono({
    this.days = 0,
    this.hours = 0,
    this.minutes = 0,
    this.seconds = 0,
    this.completed = false,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Chrono &&
          days == other.days &&
          hours == other.hours &&
          minutes == other.minutes &&
          seconds == other.seconds &&
          completed == other.completed;

  @override
  int get hashCode => Object.hash(days, hours, minutes, seconds, completed);
}
