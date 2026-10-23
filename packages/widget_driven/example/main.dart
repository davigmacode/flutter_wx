import 'package:flutter/material.dart';
import 'package:widget_driven/widget_driven.dart';

void main() {
  runApp(const DrivenExampleApp());
}

class DrivenExampleApp extends StatefulWidget {
  const DrivenExampleApp({super.key});

  @override
  State<DrivenExampleApp> createState() => _DrivenExampleAppState();
}

class _DrivenExampleAppState extends State<DrivenExampleApp> {
  late final WidgetEventController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WidgetEventController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Widget Driven Example')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DrivenBuilder(
                controller: _controller,
                builder: (context, events, child) {
                  return ElevatedButton(
                    onPressed: () {
                      _controller.toggle(WidgetEvent.loading);
                    },
                    child: const DrivenSwitcher(
                      Text('Submit Action'),
                      atLoading: DrivenSpinner(size: 20),
                    ).resolve(events),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
