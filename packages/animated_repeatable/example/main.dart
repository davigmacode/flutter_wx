import 'package:flutter/material.dart';
import 'package:animated_repeatable/animated_repeatable.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('AnimatedRepeatable Example')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Bouncing logo
              const AnimatedRepeatable(
                curve: Curves.bounceInOut,
                duration: Duration(milliseconds: 1500),
                reverse: true,
                child: FlutterLogo(size: 72),
              ),
              const SizedBox(height: 32),
              // Pulsing heart with custom zoom transition
              AnimatedRepeatable(
                mirror: true,
                curve: Curves.easeInOut,
                duration: const Duration(milliseconds: 1200),
                reverseDuration: const Duration(milliseconds: 600),
                transition: AnimatedRepeatable.zoom(0.8, 1.3),
                child: const Icon(
                  Icons.favorite,
                  size: 64,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 32),
              // Shake transition
              AnimatedRepeatable(
                duration: const Duration(milliseconds: 800),
                transition: AnimatedRepeatable.shake(),
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_active),
                  label: const Text('Shaking Alert'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
