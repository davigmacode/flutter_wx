import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wx_card/wx_card.dart';

void main() {
  group('WxCard tests', () {
    testWidgets('renders WxCard with child content',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: WxCard(
                child: Text('Card Content'),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Card Content'), findsOneWidget);
      expect(find.byType(WxCard), findsOneWidget);
    });

    testWidgets('renders WxCard with header and footer',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: WxCard(
                header: Text('Card Header'),
                footer: Text('Card Footer'),
                child: Text('Card Body'),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Card Header'), findsOneWidget);
      expect(find.text('Card Body'), findsOneWidget);
      expect(find.text('Card Footer'), findsOneWidget);
    });

    testWidgets('renders WxCard variants properly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                WxCard(
                  variant: WxCardVariant.elevated,
                  child: Text('Elevated'),
                ),
                WxCard(
                  variant: WxCardVariant.tonal,
                  child: Text('Tonal'),
                ),
                WxCard(
                  variant: WxCardVariant.outlined,
                  child: Text('Outlined'),
                ),
                WxCard(
                  variant: WxCardVariant.filled,
                  child: Text('Filled'),
                ),
              ],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Elevated'), findsOneWidget);
      expect(find.text('Tonal'), findsOneWidget);
      expect(find.text('Outlined'), findsOneWidget);
      expect(find.text('Filled'), findsOneWidget);
      expect(find.byType(WxCard), findsNWidgets(4));
    });

    testWidgets('renders WxCardTile with leading, title, subtitle, trailing',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: WxCardTile(
                leading: Icon(Icons.star, key: Key('tile-star')),
                title: Text('Tile Title'),
                subtitle: Text('Tile Subtitle'),
                trailing: Icon(Icons.arrow_forward, key: Key('tile-arrow')),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('tile-star')), findsOneWidget);
      expect(find.text('Tile Title'), findsOneWidget);
      expect(find.text('Tile Subtitle'), findsOneWidget);
      expect(find.byKey(const Key('tile-arrow')), findsOneWidget);
      expect(find.byType(WxCardTile), findsOneWidget);
    });

    testWidgets('WxCard responds to tap when onPressed is provided',
        (WidgetTester tester) async {
      int tapCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: WxCard(
                onPressed: () => tapCount++,
                child: const Text('Tappable Card'),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Tappable Card'), findsOneWidget);

      await tester.tap(find.byType(WxCard));
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pumpAndSettle();

      expect(tapCount, 1);
    });
  });
}
