import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wx_button/wx_button.dart';

void main() {
  group('WxButton tests', () {
    testWidgets('renders button with child text and responds to tap',
        (WidgetTester tester) async {
      int tapCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: WxButton(
                onPressed: () => tapCount++,
                child: const Text('Click Me'),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Click Me'), findsOneWidget);
      expect(find.byType(WxButton), findsOneWidget);

      await tester.tap(find.byType(WxButton));
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pumpAndSettle();

      expect(tapCount, 1);
    });

    testWidgets('disabled button does not invoke onPressed',
        (WidgetTester tester) async {
      int tapCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: WxButton(
                disabled: true,
                onPressed: () => tapCount++,
                child: const Text('Disabled'),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(WxButton));
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pumpAndSettle();

      expect(tapCount, 0);
    });

    testWidgets('renders all WxButton variants properly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                WxButton(
                  variant: WxButtonVariant.tonal,
                  child: Text('Tonal'),
                ),
                WxButton(
                  variant: WxButtonVariant.filled,
                  child: Text('Filled'),
                ),
                WxButton(
                  variant: WxButtonVariant.elevated,
                  child: Text('Elevated'),
                ),
                WxButton(
                  variant: WxButtonVariant.outlined,
                  child: Text('Outlined'),
                ),
                WxButton(
                  variant: WxButtonVariant.text,
                  child: Text('Text'),
                ),
              ],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Tonal'), findsOneWidget);
      expect(find.text('Filled'), findsOneWidget);
      expect(find.text('Elevated'), findsOneWidget);
      expect(find.text('Outlined'), findsOneWidget);
      expect(find.text('Text'), findsOneWidget);
      expect(find.byType(WxButton), findsNWidgets(5));
    });

    testWidgets('renders leading and trailing widgets correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: WxButton(
                leading: Icon(Icons.star, key: Key('leading-star')),
                trailing: Icon(Icons.arrow_forward, key: Key('trailing-arrow')),
                child: Text('Starred'),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('leading-star')), findsOneWidget);
      expect(find.byKey(const Key('trailing-arrow')), findsOneWidget);
      expect(find.text('Starred'), findsOneWidget);
    });

    testWidgets('WxIconButton renders icon and handles tap',
        (WidgetTester tester) async {
      int tapCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: WxIconButton(
                onPressed: () => tapCount++,
                child: const Icon(Icons.favorite),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.favorite), findsOneWidget);

      await tester.tap(find.byType(WxIconButton));
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pumpAndSettle();

      expect(tapCount, 1);
    });

    testWidgets('WxButton handles loading state',
        (WidgetTester tester) async {
      int tapCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: WxButton(
                loading: true,
                onPressed: () => tapCount++,
                child: const Text('Loading Button'),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Loading Button'), findsOneWidget);
      await tester.tap(find.byType(WxButton));
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pumpAndSettle();

      expect(tapCount, 0);
    });
  });
}
