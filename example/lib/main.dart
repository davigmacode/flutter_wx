import 'package:flutter/material.dart';
import 'package:chronograph/chronograph.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChronoGraph Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'ChronoGraph Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final ChronoGraph stopwatch;
  late final ChronoGraph timer;
  late final ChronoGraph dateCountdown;

  @override
  void initState() {
    super.initState();
    // Stopwatch (manual start/stop)
    stopwatch = ChronoGraph(
      level: ChronoLevel.seconds,
      autostart: false,
      onStart: (c) => debugPrint("Stopwatch started at ${c.inSeconds}s"),
      onPause: (c) => debugPrint("Stopwatch paused at ${c.inSeconds}s"),
      onReset: (c) => debugPrint("Stopwatch reset to ${c.inSeconds}s"),
    );

    // Timer (manual start, 10 seconds, then trigger callback)
    timer = ChronoGraph.timer(
      duration: const Duration(seconds: 10),
      autostart: false,
      onStart: (c) => debugPrint("Timer started: ${c.inSeconds}s remaining"),
      onPause: (c) => debugPrint("Timer paused: ${c.inSeconds}s remaining"),
      onReset: (c) => debugPrint("Timer reset: ${c.inSeconds}s remaining"),
      onCompleted: () {
        debugPrint("Timer finish!");
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Timer finish!")));
      },
    );

    // Countdown to a specific DateTime (auto start)
    // Example: 30 seconds from now; replace with any future date/time
    dateCountdown = ChronoGraph(
      date: DateTime.now().add(const Duration(seconds: 30)),
      onStart: (c) => debugPrint(
        "Countdown started: ${c.inSeconds}s remaining",
      ),
      onPause: (c) => debugPrint(
        "Countdown paused: ${c.inSeconds}s remaining",
      ),
      onReset: (c) => debugPrint(
        "Countdown reset: ${c.inSeconds}s remaining",
      ),
      onCompleted: () {
        debugPrint("Countdown reached target datetime!");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Countdown reached target datetime!")),
        );
      },
    );
  }

  @override
  void dispose() {
    stopwatch.dispose();
    timer.dispose();
    dateCountdown.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Stopwatch example
            const Text(
              "Stopwatch (manual)",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ChronoView(
              graph: stopwatch,
              builder: (context, info, _) {
                return Text(
                  "${info.paddedMinutes}:${info.paddedSeconds}",
                  style: const TextStyle(fontSize: 32),
                );
              },
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: stopwatch.start,
                  child: const Text("Start"),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: stopwatch.pause,
                  child: const Text("Pause"),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: stopwatch.reset,
                  child: const Text("Reset"),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Timer example
            const Text(
              "Timer 10s (manual)",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ChronoView(
              graph: timer,
              builder: (context, info, _) {
                return Text(
                  "${info.paddedMinutes}:${info.paddedSeconds}",
                  style: const TextStyle(fontSize: 32, color: Colors.red),
                );
              },
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: timer.start,
                  child: const Text("Start"),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: timer.pause,
                  child: const Text("Pause"),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: timer.reset,
                  child: const Text("Reset"),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Countdown to a specific DateTime example
            const Text(
              "Countdown to a specific DateTime (autostart)",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ChronoView(
              graph: dateCountdown,
              builder: (context, info, _) {
                // Show in mm:ss for short durations; adjust as needed
                return Text(
                  "${info.paddedMinutes}:${info.paddedSeconds}",
                  style: const TextStyle(fontSize: 32, color: Colors.blue),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
