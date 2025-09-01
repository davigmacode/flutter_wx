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
      onStart:
          (c) => debugPrint("Countdown started: ${c.inSeconds}s remaining"),
      onPause: (c) => debugPrint("Countdown paused: ${c.inSeconds}s remaining"),
      onReset: (c) => debugPrint("Countdown reset: ${c.inSeconds}s remaining"),
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
    // Stopwatch example
    final stopwatchExample = Column(
      children: [
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
        _ChronoControls(graph: stopwatch),
      ],
    );

    // Timer example
    final timerExample = Column(
      children: [
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
        _ChronoControls(graph: timer),
      ],
    );

    // Countdown to a specific DateTime example
    final countdownExample = Column(
      children: [
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
    );

    // Provider + ChronoView.of example
    final providerExample = Column(
      children: [
        const Text(
          "Using ChronoProvider + ChronoView.of",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        ChronoProvider(
          graph: ChronoGraph.stopwatch(
            level: ChronoLevel.seconds,
            interval: const Duration(seconds: 1),
            autostart: false,
          ),
          child: Builder(
            builder: (context) {
              final provided = ChronoProvider.of(context);
              return Column(
                children: [
                  ChronoView.of(
                    context,
                    builder:
                        (ctx, info, _) => Text(
                          "${info.paddedMinutes}:${info.paddedSeconds}",
                          style: const TextStyle(fontSize: 28),
                        ),
                  ),
                  const SizedBox(height: 8),
                  _ChronoControls(graph: provided),
                ],
              );
            },
          ),
        ),
      ],
    );

    // Provider.builder example
    final providerBuilderExample = Column(
      children: [
        const Text(
          "Using ChronoProvider.builder",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        ChronoProvider.builder(
          graph: ChronoGraph.timer(
            duration: const Duration(seconds: 5),
            autostart: false,
          ),
          builder: (context, graph, _) => Column(
            children: [
              ChronoView(
                graph: graph,
                builder: (ctx, info, __) => Text(
                  "${info.paddedMinutes}:${info.paddedSeconds}",
                  style: const TextStyle(fontSize: 28),
                ),
              ),
              const SizedBox(height: 8),
              _ChronoControls(graph: graph),
            ],
          ),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          spacing: 32,
          children: <Widget>[
            stopwatchExample,
            timerExample,
            countdownExample,
            providerExample,
            providerBuilderExample,
          ],
        ),
      ),
    );
  }
}

class _ChronoControls extends StatelessWidget {
  const _ChronoControls({required this.graph});

  final ChronoGraph graph;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(onPressed: graph.start, child: const Text('Start')),
        const SizedBox(width: 8),
        ElevatedButton(onPressed: graph.pause, child: const Text('Pause')),
        const SizedBox(width: 8),
        ElevatedButton(onPressed: graph.reset, child: const Text('Reset')),
      ],
    );
  }
}
