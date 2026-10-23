import 'package:flutter/material.dart';
import 'package:widget_event/widget_event.dart';

void main() {
  runApp(const WidgetEventExampleApp());
}

class WidgetEventExampleApp extends StatefulWidget {
  const WidgetEventExampleApp({super.key});

  @override
  State<WidgetEventExampleApp> createState() => _WidgetEventExampleAppState();
}

class _WidgetEventExampleAppState extends State<WidgetEventExampleApp> {
  final WidgetEventController _controller = WidgetEventController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('WidgetEvent Demo')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _controller,
                builder: (context, _) {
                  final active = _controller.value;
                  final color = DrivenColor.by((events) {
                    if (events.contains(WidgetEvent.loading)) return Colors.orange;
                    return Colors.blue;
                  }).resolve(active);

                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'State: ${active.isEmpty ? "Idle" : active.map((e) => e.value).join(", ")}',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  _controller.toggle(WidgetEvent.loading);
                },
                child: const Text('Toggle Loading State'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
