import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wx_text/wx_text.dart';
import 'package:wx_text_animated/wx_text_animated.dart';

void main() {
  group('WxAnimatedText', () {
    testWidgets('renders child text and supports disableAnimations', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: WxAnimatedText(
              disableAnimations: true,
              transition: WxAnimatedText.fade,
              child: WxText('Static animated text'),
            ),
          ),
        ),
      );

      expect(find.text('Static animated text'), findsOneWidget);
    });

    testWidgets('renders shimmer, typing, slide, shake, and fade transitions', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  WxAnimatedText(
                    transition: WxAnimatedText.shimmer(
                      colors: [Colors.blue, Colors.white],
                    ),
                    child: const WxText('Shimmer'),
                  ),
                  WxAnimatedText(
                    transition: WxAnimatedText.zoom(),
                    child: const WxText('Zoom'),
                  ),
                  WxAnimatedText(
                    transition: WxAnimatedText.slide(const Offset(10, 0)),
                    child: const WxText('Slide'),
                  ),
                  WxAnimatedText(
                    transition: WxAnimatedText.shake(),
                    child: const WxText('Shake'),
                  ),
                  const WxAnimatedText(
                    transition: WxAnimatedText.fade,
                    child: WxText('Fade'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.text('Shimmer'), findsOneWidget);
      expect(find.text('Zoom'), findsOneWidget);
      expect(find.text('Slide'), findsOneWidget);
      expect(find.text('Shake'), findsOneWidget);
      expect(find.text('Fade'), findsOneWidget);
    });

    testWidgets('animates typing transition properly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WxAnimatedText(
              duration: const Duration(milliseconds: 500),
              transition: WxAnimatedText.typing(trails: '_'),
              child: const WxText('Hello'),
            ),
          ),
        ),
      );

      // Verify typing widget renders RichText spans
      expect(find.byType(RichText), findsWidgets);
      await tester.pump(const Duration(milliseconds: 250));
      expect(find.byType(RichText), findsWidgets);
    });
  });
}
