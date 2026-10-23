import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widget_event/widget_event.dart';
import 'package:wx_anchor/wx_anchor.dart';

void main() {
  group('WxAnchor Widget Tests', () {
    testWidgets('renders child widget properly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WxAnchor(
              child: const Text('Anchor Target'),
            ),
          ),
        ),
      );

      expect(find.text('Anchor Target'), findsOneWidget);
      expect(find.byType(WxAnchor), findsOneWidget);
    });

    testWidgets('triggers onTap callback when tapped', (tester) async {
      int tapCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WxAnchor(
              onTap: () => tapCount++,
              child: const Text('Tap Me'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Tap Me'));
      await tester.pumpAndSettle();

      expect(tapCount, equals(1));
    });

    testWidgets('WxAnchor.circle constructs circular shape area', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WxAnchor.circle(
              overlayRadius: 30,
              child: const Icon(Icons.favorite),
            ),
          ),
        ),
      );

      expect(find.byType(WxAnchor), findsOneWidget);
      expect(find.byIcon(Icons.favorite), findsOneWidget);
    });

    testWidgets('synchronizes interaction state with WidgetEventController', (tester) async {
      final controller = WidgetEventController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WxAnchor(
              eventsController: controller,
              onTap: () {},
              child: const SizedBox(width: 100, height: 100, child: Text('Zone')),
            ),
          ),
        ),
      );

      expect(controller.isPressed, isFalse);

      // Press down
      final gesture = await tester.startGesture(tester.getCenter(find.text('Zone')));
      await tester.pump();
      expect(controller.isPressed, isTrue);

      // Release
      await gesture.up();
      await tester.pumpAndSettle();
      expect(controller.isPressed, isFalse);

      controller.dispose();
    });

    testWidgets('respects disabled state by preventing interaction', (tester) async {
      int tapCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WxAnchor(
              disabled: true,
              onTap: () => tapCount++,
              child: const Text('Disabled Anchor'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Disabled Anchor'));
      await tester.pumpAndSettle();

      expect(tapCount, equals(0));
    });

    testWidgets('inherits styling from WxAnchorTheme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WxAnchorTheme(
              data: const WxAnchorThemeData(
                duration: Duration(milliseconds: 250),
                style: WxAnchorStyle(
                  scale: 1.1,
                  opacity: 0.9,
                ),
              ),
              child: WxAnchor(
                child: const Text('Themed Anchor'),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Themed Anchor'), findsOneWidget);
      final theme = WxAnchorTheme.of(tester.element(find.text('Themed Anchor')));
      expect(theme.duration, equals(const Duration(milliseconds: 250)));
      expect(theme.style.scale, equals(1.1));
      expect(theme.style.opacity, equals(0.9));
    });
  });
}
