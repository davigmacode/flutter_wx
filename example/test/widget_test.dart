import 'package:flutter_test/flutter_test.dart';
import 'package:widgetarian_showroom/main.dart';
import 'package:widgetarian/widgetarian.dart';

void main() {
  testWidgets('Widgetarian Showroom smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const WidgetarianShowroomApp());

    expect(find.byType(WidgetarianShowroomApp), findsOneWidget);
    expect(find.text('Widgetarian Showroom'), findsOneWidget);
    expect(find.byType(WxText), findsWidgets);
  });
}
