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
                  final spinner = const DrivenSpinner(size: 48, color: Colors.blue).resolve(_controller.value);
                  return spinner ?? const Icon(Icons.refresh, size: 48);
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
