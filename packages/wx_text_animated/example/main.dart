import 'package:flutter/material.dart';
import 'package:wx_text/wx_text.dart';
import 'package:wx_text_animated/wx_text_animated.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('WxAnimatedText Example')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Shimmer transition
              WxAnimatedText(
                transition: WxAnimatedText.shimmer(
                  colors: [Colors.purple, Colors.teal, Colors.purple],
                ),
                child: const WxText.headlineMedium('Shimmering Headline'),
              ),
              const SizedBox(height: 24),
              // Typing transition
              WxAnimatedText(
                duration: const Duration(seconds: 2),
                transition: WxAnimatedText.typing(trails: '_'),
                child: const WxText.bodyLarge('Typewriter effect with trailing cursor...'),
              ),
              const SizedBox(height: 24),
              // Shake transition
              const WxAnimatedText(
                transition: WxAnimatedText.shakeX,
                child: WxText('Shake animation effect'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
