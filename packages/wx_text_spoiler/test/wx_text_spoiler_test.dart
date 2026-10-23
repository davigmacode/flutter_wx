import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wx_text_spoiler/wx_text_spoiler.dart';

void main() {
  group('WxSpoilerText', () {
    testWidgets('toggles visibility and fires onExpanded callback', (tester) async {
      bool? isExpandedResult;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WxSpoilerText(
              'This is a long spoiler text that should be collapsible',
              maxLines: 1,
              expanded: false,
              onExpanded: (value) {
                isExpandedResult = value;
              },
            ),
          ),
        ),
      );

      expect(find.byType(AnimatedCrossFade), findsOneWidget);
      expect(isExpandedResult, isNull);

      // Tap to toggle expanded
      await tester.tap(find.byType(WxSpoilerText));
      await tester.pumpAndSettle();

      expect(isExpandedResult, isTrue);

      // Tap again to toggle collapsed
      await tester.tap(find.byType(WxSpoilerText));
      await tester.pumpAndSettle();

      expect(isExpandedResult, isFalse);
    });

    testWidgets('preserves expanded state when parent rebuilds', (tester) async {
      final valueNotifier = ValueNotifier<int>(0);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ValueListenableBuilder<int>(
              valueListenable: valueNotifier,
              builder: (context, val, child) {
                return WxSpoilerText(
                  'Persistent spoiler text counter: $val',
                  maxLines: 1,
                  expanded: false,
                );
              },
            ),
          ),
        ),
      );

      // Tap spoiler to expand
      await tester.tap(find.byType(WxSpoilerText));
      await tester.pumpAndSettle();

      final crossFadeBefore = tester.widget<AnimatedCrossFade>(find.byType(AnimatedCrossFade));
      expect(crossFadeBefore.crossFadeState, CrossFadeState.showSecond);

      // Rebuild parent by changing valueNotifier
      valueNotifier.value = 1;
      await tester.pumpAndSettle();

      // State must remain expanded
      final crossFadeAfter = tester.widget<AnimatedCrossFade>(find.byType(AnimatedCrossFade));
      expect(crossFadeAfter.crossFadeState, CrossFadeState.showSecond);
    });

    test('WxSpoilerController supports expand, collapse, toggle, and listeners', () {
      bool? notified;
      final controller = WxSpoilerController(
        expanded: false,
        onExpanded: (val) => notified = val,
      );

      expect(controller.expanded, isFalse);

      controller.expand();
      expect(controller.expanded, isTrue);
      expect(notified, isTrue);

      controller.collapse();
      expect(controller.expanded, isFalse);
      expect(notified, isFalse);

      controller.toggle();
      expect(controller.expanded, isTrue);

      controller.expanded = false;
      expect(controller.expanded, isFalse);
    });

    testWidgets('supports external WxSpoilerController and WxSpoilerProvider', (tester) async {
      final controller = WxSpoilerController();
      WxSpoilerController? providedController;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WxSpoilerText(
              'Managed spoiler content text',
              maxLines: 1,
              controller: controller,
              wrapper: (context, child, toggle) {
                providedController = WxSpoilerProvider.of(context);
                return child;
              },
            ),
          ),
        ),
      );

      expect(providedController, same(controller));
      expect(controller.expanded, isFalse);

      controller.expand();
      await tester.pumpAndSettle();

      final crossFade = tester.widget<AnimatedCrossFade>(find.byType(AnimatedCrossFade));
      expect(crossFade.crossFadeState, CrossFadeState.showSecond);
    });
  });
}
