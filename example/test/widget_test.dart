import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetarian_showroom/main.dart';

void main() {
  testWidgets('Widgetarian Showroom smoke test', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1280, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const WidgetarianShowroomApp());
    await tester.pumpAndSettle();

    expect(find.byType(WidgetarianShowroomApp), findsOneWidget);
    expect(find.text('Widgetarian Showroom'), findsOneWidget);
    expect(find.text('The Widgetarian UI Toolkit'), findsOneWidget);
  });
}
