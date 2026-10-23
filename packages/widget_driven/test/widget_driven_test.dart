import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widget_driven/widget_driven.dart';

void main() {
  group('DrivenChild Tests', () {
    testWidgets('resolves fallback atEnabled when events are empty', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DrivenChild(
              Text('Enabled Content'),
              atLoading: Text('Loading Content'),
              atError: Text('Error Content'),
            ),
          ),
        ),
      );

      expect(find.text('Enabled Content'), findsOneWidget);
      expect(find.text('Loading Content'), findsNothing);
    });

    test('resolves appropriate child based on events set', () {
      const child = DrivenChild<Widget>(
        Text('Enabled'),
        atLoading: Text('Loading'),
        atDisabled: Text('Disabled'),
        atError: Text('Error'),
      );

      expect(child.resolve({}).toString(), contains('Enabled'));
      expect(child.resolve({WidgetEvent.loading}).toString(), contains('Loading'));
      expect(child.resolve({WidgetEvent.disabled}).toString(), contains('Disabled'));
      expect(child.resolve({WidgetEvent.error}).toString(), contains('Error'));
    });
  });

  group('DrivenBuilder Tests', () {
    testWidgets('rebuilds when controller events change', (tester) async {
      final controller = WidgetEventController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DrivenBuilder(
              controller: controller,
              builder: (context, events, _) {
                if (events.contains(WidgetEvent.loading)) {
                  return const Text('State: Loading');
                }
                return const Text('State: Idle');
              },
            ),
          ),
        ),
      );

      expect(find.text('State: Idle'), findsOneWidget);

      controller.add(WidgetEvent.loading);
      await tester.pump();

      expect(find.text('State: Loading'), findsOneWidget);

      controller.remove(WidgetEvent.loading);
      await tester.pump();

      expect(find.text('State: Idle'), findsOneWidget);

      controller.dispose();
    });
  });

  group('DrivenSpinner Tests', () {
    testWidgets('renders CircularProgressIndicator on atLoading', (tester) async {
      const spinner = DrivenSpinner(size: 24, width: 3, color: Colors.blue);
      final widget = spinner.atLoading;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: widget!,
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      final progress = tester.widget<CircularProgressIndicator>(
        find.byType(CircularProgressIndicator),
      );
      expect(progress.strokeWidth, equals(3));
      expect(progress.color, equals(Colors.blue));
    });

    test('DrivenSpinnerThemeData copyWith, lerp, and equality', () {
      const data1 = DrivenSpinnerThemeData(size: 20, width: 2, color: Colors.red);
      const data2 = DrivenSpinnerThemeData(size: 30, width: 4, color: Colors.blue);

      expect(data1 == data2, isFalse);
      final copied = data1.copyWith(size: 25);
      expect(copied.size, equals(25));
      expect(copied.width, equals(2));

      final lerped = data1.lerp(data2, 0.5);
      expect(lerped.size, equals(25));
      expect(lerped.width, equals(3));
    });
  });

  group('DrivenSwitcher Tests', () {
    testWidgets('DrivenSwitcher builds within AnimatedSwitcher', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DrivenSwitcher(
              Text('Idle'),
              atLoading: Text('Loading'),
            ),
          ),
        ),
      );

      expect(find.byType(AnimatedSwitcher), findsOneWidget);
      expect(find.text('Idle'), findsOneWidget);
    });

    test('DrivenSwitcherThemeData copyWith, lerp, and merge', () {
      const data1 = DrivenSwitcherThemeData(duration: Duration(milliseconds: 100));
      const data2 = DrivenSwitcherThemeData(duration: Duration(milliseconds: 300));

      final merged = data1.merge(data2);
      expect(merged.duration, equals(const Duration(milliseconds: 300)));
    });
  });
}
