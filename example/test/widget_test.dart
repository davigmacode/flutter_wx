import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetarian/widgetarian.dart';
import 'package:widgetarian_showroom/main.dart';
import 'package:widgetarian_showroom/showcases/surfaces_showcases.dart';

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

  testWidgets('WxSheetShowcase renders properly with visual sheets',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1280, 1000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: WxSheetShowcase(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Tonal'), findsOneWidget);
    expect(find.text('Elevated'), findsOneWidget);
    expect(find.text('Filled'), findsOneWidget);
    expect(find.text('Outlined'), findsOneWidget);
    expect(find.byType(WxStaticSheet), findsNWidgets(4));
    expect(find.byType(WxTapSheet), findsOneWidget);
    expect(find.byType(WxToggleSheet), findsOneWidget);
  });
}
