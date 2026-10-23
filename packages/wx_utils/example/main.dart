import 'package:flutter/material.dart';
import 'package:wx_utils/wx_utils.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Colors.deepPurple;
    final onPrimary = WxColors.onSurface(primaryColor);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('WxUtils Example')),
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              'Dynamic contrasting text',
              style: TextStyle(color: onPrimary, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
