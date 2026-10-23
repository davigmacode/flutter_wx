import 'package:flutter/material.dart';
import 'package:wx_spoiler/wx_spoiler.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text('WxSpoiler Example')),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: ListView(
              padding: const EdgeInsets.all(24.0),
              children: [
                const Text(
                  'Collapsible Text Spoiler',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                const WxSpoilerText(
                  'This is a long spoiler text that is initially collapsed. '
                  'Tap anywhere to smoothly expand the content and read the full details. '
                  'Tap again to collapse it back!',
                  maxLines: 2,
                ),
                const SizedBox(height: 32),
                const Text(
                  'Widget / Image Spoiler (Tap to Reveal)',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                WxSpoiler(
                  overlay: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.visibility_off, color: Colors.white, size: 18),
                        SizedBox(width: 8),
                        Text('Tap to Reveal', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  child: Container(
                    height: 180,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.deepPurple, Colors.indigoAccent],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      '🎉 Secret Revealed Content! 🚀',
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
