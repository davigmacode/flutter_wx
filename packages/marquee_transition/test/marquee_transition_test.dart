import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marquee_transition/marquee_transition.dart';

void main() {
  group('MarqueeTransition', () {
    testWidgets('renders children inside scroll view', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 200,
              child: MarqueeTransition(
                duration: Duration(seconds: 1),
                children: [
                  Text('Marquee Item 1'),
                  Text('Marquee Item 2'),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.text('Marquee Item 1'), findsWidgets);
      expect(find.text('Marquee Item 2'), findsWidgets);
    });
  });
}
