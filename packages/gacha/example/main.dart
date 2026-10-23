import 'package:flutter/material.dart';
import 'package:gacha/gacha.dart';

void main() {
  runApp(const GachaExampleApp());
}

class GachaExampleApp extends StatefulWidget {
  const GachaExampleApp({super.key});

  @override
  State<GachaExampleApp> createState() => _GachaExampleAppState();
}

class _GachaExampleAppState extends State<GachaExampleApp> {
  late Gacha gacha;
  String currentEmail = '';
  String currentPhone = '';
  int currentInteger = 0;
  String currentWord = '';

  @override
  void initState() {
    super.initState();
    gacha = Gacha.instance;
    _generate();
  }

  void _generate() {
    setState(() {
      currentEmail = gacha.email();
      currentPhone = gacha.phone();
      currentInteger = gacha.integer(min: 1, max: 100);
      currentWord = gacha.words(3);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Gacha Example')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Email: $currentEmail'),
              const SizedBox(height: 8),
              Text('Phone: $currentPhone'),
              const SizedBox(height: 8),
              Text('Integer: $currentInteger'),
              const SizedBox(height: 8),
              Text('Words: $currentWord'),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _generate,
                icon: const Icon(Icons.refresh),
                label: const Text('Roll Gacha'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
