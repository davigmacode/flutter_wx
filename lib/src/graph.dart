import 'dart:async';
import 'model.dart';

class ChronoGraph {
  final Duration interval;
  final ChronoLevel level;
  final DateTime? date;

  late final StreamController<Chrono> _streamController;
  late final Stopwatch _stopwatch;
  bool _isRunning = false;
  Timer? _timer;

  ChronoGraph({
    this.interval = const Duration(seconds: 1),
    this.level = ChronoLevel.seconds,
    this.date,
  }) {
    _stopwatch = Stopwatch();
    _streamController = StreamController<Chrono>.broadcast();
  }

  Stream<Chrono> get stream => _streamController.stream;

  void _updateTime() {
    int totalSeconds;

    if (date == null) {
      totalSeconds = _stopwatch.elapsed.inSeconds;
    } else {
      int remaining = date!.difference(DateTime.now()).inSeconds;
      totalSeconds = remaining > 0 ? remaining : 0;
    }

    bool isCompleted = date != null && totalSeconds == 0;
    if (isCompleted) {
      pause();
    }

    int d = totalSeconds ~/ 86400;
    int h = (totalSeconds % 86400) ~/ 3600;
    int m = (totalSeconds % 3600) ~/ 60;
    int s = totalSeconds % 60;

    switch (level) {
      case ChronoLevel.days:
        h += d * 24;
        d = 0;
      case ChronoLevel.hours:
        m += h * 60;
        h = 0;
      case ChronoLevel.minutes:
        s += m * 60;
        m = 0;
      case ChronoLevel.seconds:
        break;
    }

    _streamController.add(
      Chrono(
        days: d,
        hours: h,
        minutes: m,
        seconds: s,
        completed: isCompleted,
        running: _isRunning,
        level: level,
      ),
    );
  }

  void start() {
    if (!_isRunning) {
      _stopwatch.start();
      _isRunning = true;
      _timer = Timer.periodic(interval, (_) => _updateTime());
    }
  }

  void pause() {
    _stopwatch.stop();
    _isRunning = false;
    _timer?.cancel();
  }

  void reset() {
    _stopwatch.reset();
    _updateTime();
  }

  void dispose() {
    _timer?.cancel();
    _streamController.close();
  }
}
