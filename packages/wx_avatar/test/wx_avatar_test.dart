import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wx_avatar/wx_avatar.dart';

void main() {
  group('WxAvatar', () {
    testWidgets('renders child and shape correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: WxAvatar.circle(
              child: Text('AV'),
            ),
          ),
        ),
      );

      expect(find.text('AV'), findsOneWidget);
      expect(find.byType(WxAvatar), findsOneWidget);
    });
  });
}
