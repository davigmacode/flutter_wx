import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wx_chip/wx_chip.dart';

void main() {
  group('WxChip tests', () {
    testWidgets('renders WxChip with text child',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: WxChip(
                child: Text('Chip Label'),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Chip Label'), findsOneWidget);
      expect(find.byType(WxChip), findsOneWidget);
    });

    testWidgets('renders WxChip with leading and trailing widgets',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: WxChip(
                leading: Icon(Icons.star, key: Key('chip-leading')),
                trailing: Icon(Icons.close, key: Key('chip-trailing')),
                child: Text('With Icons'),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('chip-leading')), findsOneWidget);
      expect(find.text('With Icons'), findsOneWidget);
      expect(find.byKey(const Key('chip-trailing')), findsOneWidget);
    });

    testWidgets('renders WxChip variants properly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                WxChip(
                  variant: WxChipVariant.tonal,
                  child: Text('Tonal'),
                ),
                WxChip(
                  variant: WxChipVariant.filled,
                  child: Text('Filled'),
                ),
                WxChip(
                  variant: WxChipVariant.elevated,
                  child: Text('Elevated'),
                ),
                WxChip(
                  variant: WxChipVariant.outlined,
                  child: Text('Outlined'),
                ),
              ],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Tonal'), findsOneWidget);
      expect(find.text('Filled'), findsOneWidget);
      expect(find.text('Elevated'), findsOneWidget);
      expect(find.text('Outlined'), findsOneWidget);
      expect(find.byType(WxChip), findsNWidgets(4));
    });

    testWidgets('WxChip handles tap when onPressed is supplied',
        (WidgetTester tester) async {
      int tapCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: WxChip(
                onPressed: () => tapCount++,
                child: const Text('Action Chip'),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(WxChip));
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pumpAndSettle();

      expect(tapCount, 1);
    });

    testWidgets('WxChip handles selection toggle when onSelected is supplied',
        (WidgetTester tester) async {
      bool isSelected = false;

      await tester.pumpWidget(
        StatefulBuilder(
          builder: (context, setState) {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: WxChip(
                    selected: isSelected,
                    onSelected: (val) => setState(() => isSelected = val),
                    child: const Text('Selectable Chip'),
                  ),
                ),
              ),
            );
          },
        ),
      );
      await tester.pumpAndSettle();

      expect(isSelected, false);

      await tester.tap(find.byType(WxChip));
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pumpAndSettle();

      expect(isSelected, true);
    });

    testWidgets('disabled WxChip does not invoke callbacks',
        (WidgetTester tester) async {
      int tapCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: WxChip(
                disabled: true,
                onPressed: () => tapCount++,
                child: const Text('Disabled Chip'),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(WxChip));
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pumpAndSettle();

      expect(tapCount, 0);
    });
  });
}
