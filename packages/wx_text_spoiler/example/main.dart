import 'package:flutter/material.dart';
import 'package:wx_text_spoiler/wx_text_spoiler.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('WxSpoilerText Example')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: WxSpoilerText(
              'This is a long spoiler text that is initially collapsed. '
              'Tap anywhere to smoothly expand the content and read the full details. '
              'Tap again to collapse it back!',
              maxLines: 2,
              onExpanded: (expanded) {
                debugPrint('Spoiler expanded: $expanded');
              },
            ),
          ),
        ),
      ),
    );
  }
}
