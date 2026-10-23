import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetarian/widgetarian.dart';

void main() {
  group('Widgetarian Umbrella Package', () {
    testWidgets('exports and instantiates key components', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                WxText('Widgetarian Text'),
                WxAvatar.circle(child: Text('W')),
                WxTile(child: Text('Tile')),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Widgetarian Text'), findsOneWidget);
      expect(find.text('W'), findsOneWidget);
      expect(find.text('Tile'), findsOneWidget);

      final controller = WidgetEventController();
      controller.add(WidgetEvent.loading);
      expect(controller.value.contains(WidgetEvent.loading), isTrue);
      controller.dispose();
    });
  });
}
