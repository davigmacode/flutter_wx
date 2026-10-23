import 'package:flutter/material.dart';
import 'package:widgetarian/widgetarian.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Widgetarian Umbrella Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Widgetarian Toolkit')),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: const [
                WxText.titleLarge(
                  'All-In-One Widgetarian Toolkit',
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 16),
                WxListTile(
                  leading: WxAvatar.circle(child: Text('W')),
                  title: Text('One import for everything'),
                  subtitle: Text('package:widgetarian/widgetarian.dart'),
                  trailing: WxBadge(
                    content: Text('v1.0'),
                    child: Icon(Icons.star, color: Colors.amber),
                  ),
                ),
                SizedBox(height: 24),
                WxSpoiler(
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('Secret content concealed by WxSpoiler!'),
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
