import 'package:flutter/material.dart';
import 'package:wx_badge/wx_badge.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatefulWidget {
  const ExampleApp({super.key});

  @override
  State<ExampleApp> createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  int count = 3;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('WxBadge Example')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WxBadge(
                content: Text('$count'),
                position: WxBadgePosition.topRight,
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.notifications, size: 28),
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilledButton(
                    onPressed: () => setState(() => count++),
                    child: const Text('Increment'),
                  ),
                  const SizedBox(width: 12),
                  OutlinedButton(
                    onPressed: () => setState(() => count > 0 ? count-- : 0),
                    child: const Text('Decrement'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
