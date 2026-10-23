import 'package:flutter/material.dart';
import 'package:wx_layout/wx_layout.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('WxLayout Example')),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Top Element'),
                const WxGap(24),
                WxBox(
                  padding: const EdgeInsets.all(20),
                  color: Colors.indigo.shade50,
                  borderRadius: BorderRadius.circular(12),
                  child: const Text('Styled with WxBox'),
                ),
                const WxGap(24),
                const Text('Bottom Element'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
