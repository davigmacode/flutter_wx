import 'dart:async';
import 'model.dart';

class ChronoGraph {
  final Duration interval;
  final ChronoLevel level;
  final DateTime? date; // Jika null -> count-up, Jika diisi -> count-down

  late final StreamController<Chrono> _streamController;
  late final Stopwatch _stopwatch;
  bool _isRunning = false;
  Timer? _timer;

  ChronoGraph({
    this.interval = const Duration(seconds: 1),
    this.level = ChronoLevel.seconds,
    this.date, // Digunakan untuk count-down
  }) {
    _stopwatch = Stopwatch();
    _streamController = StreamController<Chrono>.broadcast();
  }

  Stream<Chrono> get stream => _streamController.stream;

  void _updateTime() {
    int totalSeconds;

    if (date == null) {
      // Mode Count-Up (Menghitung maju)
      totalSeconds = _stopwatch.elapsed.inSeconds;
    } else {
      // Mode Count-Down (Menghitung mundur ke `date`)
      int remaining = date!.difference(DateTime.now()).inSeconds;
      totalSeconds = remaining > 0 ? remaining : 0;
    }

    bool isCompleted = date != null && totalSeconds == 0;
    if (isCompleted) {
      pause(); // Hentikan otomatis jika count-down selesai
    }

    int d = totalSeconds ~/ 86400;
    int h = (totalSeconds % 86400) ~/ 3600;
    int m = (totalSeconds % 3600) ~/ 60;
    int s = totalSeconds % 60;

    // Atur format berdasarkan `level`
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
      Chrono(days: d, hours: h, minutes: m, seconds: s, completed: isCompleted),
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
