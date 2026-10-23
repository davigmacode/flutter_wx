import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wx_badge/wx_badge.dart';

void main() {
  group('WxBadge', () {
    testWidgets('renders child and badge content', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: WxBadge(
              content: Text('5'),
              child: Icon(Icons.shopping_cart),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.shopping_cart), findsOneWidget);
      expect(find.text('5'), findsOneWidget);
    });
  });
}
