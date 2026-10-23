import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fancy_border/fancy_border.dart';

void main() {
  group('FancyBorder', () {
    testWidgets('paints with FancyBorder decoration', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Container(
              width: 100,
              height: 50,
              decoration: const ShapeDecoration(
                shape: FancyBorder(
                  style: FancyBorderStyle.dashed,
                  width: 2,
                  color: Colors.blue,
                ),
              ),
              child: const Text('Dashed'),
            ),
          ),
        ),
      );

      expect(find.text('Dashed'), findsOneWidget);
    });
  });
}
