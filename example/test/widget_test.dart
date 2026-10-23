import 'package:flutter_test/flutter_test.dart';
import 'package:wx_text/wx_text.dart';
import 'package:wx_text_example/main.dart';

void main() {
  testWidgets('Example app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byType(MyApp), findsOneWidget);
    expect(find.byType(WxText), findsWidgets);
  });
}
