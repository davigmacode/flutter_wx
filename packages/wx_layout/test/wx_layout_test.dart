import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wx_layout/wx_layout.dart';

void main() {
  group('WxLayout', () {
    testWidgets('renders WxGap and WxBox', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                Text('First'),
                WxGap(16),
                WxBox(
                  child: Text('Inside Box'),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('First'), findsOneWidget);
      expect(find.byType(WxGap), findsOneWidget);
      expect(find.text('Inside Box'), findsOneWidget);
    });
  });
}
