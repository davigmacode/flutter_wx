import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetarian/widgetarian.dart';

void main() {
  group('Widgetarian Umbrella Package', () {
    testWidgets('exports and instantiates key components', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                const WxText('Widgetarian Text'),
                const WxAvatar.circle(child: Text('W')),
                const WxTile(child: Text('Tile')),
                WxAnchor(child: const Text('Anchor')),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Widgetarian Text'), findsOneWidget);
      expect(find.text('W'), findsOneWidget);
      expect(find.text('Tile'), findsOneWidget);
      expect(find.text('Anchor'), findsOneWidget);

      final controller = WidgetEventController();
      controller.add(WidgetEvent.loading);
      expect(controller.value.contains(WidgetEvent.loading), isTrue);
      controller.dispose();
    });
  });
}
