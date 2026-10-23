import 'package:flutter/material.dart';
import 'package:wx_text/wx_text.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('WxText Example')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Typography shortcuts & styling
              const WxText.headlineMedium(
                'Hello Flutter',
                fontWeight: FontWeight.bold,
                gradient: LinearGradient(
                  colors: [Colors.purple, Colors.blue],
                ),
              ),
              const SizedBox(height: 16),
              // Outline styling
              const WxText(
                'Outlined Text',
                style: TextStyle(fontSize: 28),
                outlineColor: Colors.black,
                outlineWidth: 2,
              ),
              const SizedBox(height: 16),
              // Pattern filtering (URLs, mentions, emails)
              WxText(
                'Visit https://flutter.dev or tag @flutter for more info!',
                filter: [
                  WxTextFilter.url(
                    onTap: (url) => debugPrint('Tapped URL: $url'),
                  ),
                  WxTextFilter.mention(
                    onTap: (tag) => debugPrint('Tapped mention: $tag'),
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
