import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wx_tile/wx_tile.dart';

void main() {
  group('WxTile', () {
    testWidgets('renders child, leading and trailing', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: WxTile(
              leading: Text('Lead'),
              trailing: Text('Trail'),
              child: Text('Content'),
            ),
          ),
        ),
      );

      expect(find.text('Lead'), findsOneWidget);
      expect(find.text('Trail'), findsOneWidget);
      expect(find.text('Content'), findsOneWidget);
    });

    testWidgets('renders WxListTile with title and subtitle', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: WxListTile(
              title: Text('My Title'),
              subtitle: Text('My Subtitle'),
            ),
          ),
        ),
      );

      expect(find.text('My Title'), findsOneWidget);
      expect(find.text('My Subtitle'), findsOneWidget);
    });
  });
}
