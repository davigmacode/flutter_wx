import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:wheel_choice/wheel_choice.dart';

Widget _wrap(Widget child) => MaterialApp(
  home: Scaffold(body: Center(child: child)),
);

void main() {
  testWidgets('WheelChoice builds and shows header and overlay', (
    tester,
  ) async {
    final controller = WheelController<String>(
      options: const ['A', 'B', 'C'],
      value: 'A',
    );
    await tester.pumpWidget(
      _wrap(
        WheelChoice<String>.raw(
          controller: controller,
          header: const WheelHeader(child: Text('Header')),
          overlay: (_) => Container(key: const Key('overlay')),
        ),
      ),
    );

    expect(find.text('Header'), findsOneWidget);
    expect(find.byKey(const Key('overlay')), findsOneWidget);
  });

  testWidgets('WheelChoice onChanged fires when selecting enabled item', (
    tester,
  ) async {
    String? changed;
    final controller = WheelController<String>(
      options: const ['One', 'Two', 'Three'],
      value: 'One',
      onChanged: (v) => changed = v,
    );
    await tester.pumpWidget(
      _wrap(
        WheelChoice<String>.raw(
          controller: controller,
        ),
      ),
    );

    // Drag up roughly one item extent to move selection to 'Two'.
    await tester.drag(find.byType(ListWheelScrollView), const Offset(0, -40));
    await tester.pumpAndSettle();

    expect(changed, equals('Two'));
    expect(controller.selectedItem % 3, 1);
  });

  testWidgets('WheelChoice skips disabled item after scroll end (finite)', (
    tester,
  ) async {
    final calls = <String>[];
    final controller = WheelController<String>(
      options: const ['A', 'B', 'C'],
      value: 'A',
      itemDisabled: (v) => v == 'B',
      onChanged: calls.add,
    );
    await tester.pumpWidget(
      _wrap(
        WheelChoice<String>.raw(
          controller: controller,
        ),
      ),
    );

    // Attempt to land on disabled 'B'. The picker should settle on 'C'.
    await tester.drag(find.byType(ListWheelScrollView), const Offset(0, -40));
    await tester.pumpAndSettle();

    // Should not call with 'B'; final selection should be 'C'.
    expect(calls.contains('B'), isFalse);
    expect(calls.contains('C'), isTrue);
    expect(controller.selectedItem, 2);
  });

  testWidgets('WheelChoice loop mode: disabled snaps to nearest enabled', (
    tester,
  ) async {
    final calls = <String>[];
    final controller = WheelController<String>(
      options: const ['A', 'B', 'C'],
      value: 'B', // Start at 'B'
      loop: true,
      itemDisabled: (v) => v == 'A',
      onChanged: calls.add,
    );
    await tester.pumpWidget(
      _wrap(
        WheelChoice<String>.raw(
          controller: controller,
        ),
      ),
    );

    // Try to go to disabled 'A' (drag down to move selection up by -1 index)
    // Use a slightly larger drag to ensure boundary crossing on all platforms.
    await tester.drag(find.byType(ListWheelScrollView), const Offset(0, 50));
    await tester.pumpAndSettle();

    // In loop, landing on disabled 'A' should snap to a non-disabled option.
    // onChanged may not fire if it snaps back to the original value ('B').
    expect(calls.contains('A'), isFalse);
    expect(controller.selectedItem % 3, isNot(0));
  });

  testWidgets('WheelEffect props are applied to ListWheelScrollView', (
    tester,
  ) async {
    const effect = WheelEffect(
      useMagnifier: true,
      magnification: 1.2,
      diameterRatio: 2.5,
      perspective: 0.004,
      offAxisFraction: 0.1,
      overAndUnderCenterOpacity: 0.6,
      squeeze: 0.9,
    );

    await tester.pumpWidget(
      _wrap(
        WheelChoice<String>(
          options: ['X', 'Y', 'Z'],
          value: 'X',
          effect: effect,
        ),
      ),
    );

    final wheel = tester.widget<ListWheelScrollView>(
      find.byType(ListWheelScrollView),
    );
    expect(wheel.useMagnifier, isTrue);
    expect(wheel.magnification, equals(1.2));
    expect(wheel.diameterRatio, equals(2.5));
    expect(wheel.perspective, equals(0.004));
    expect(wheel.offAxisFraction, equals(0.1));
    expect(wheel.overAndUnderCenterOpacity, equals(0.6));
    expect(wheel.squeeze, equals(0.9));
  });

  testWidgets(
    'WheelChoice updates when options change dynamically (didUpdateWidget)',
    (
      tester,
    ) async {
      List<String> options = ['Alpha', 'Beta'];
      String selected = 'Alpha';

      await tester.pumpWidget(
        StatefulBuilder(
          builder: (context, setState) {
            return _wrap(
              Column(
                children: [
                  WheelChoice<String>(
                    options: options,
                    value: selected,
                    onChanged: (v) => selected = v,
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        options = ['One', 'Two', 'Three'];
                        selected = 'Two';
                      });
                    },
                    child: const Text('Update'),
                  ),
                ],
              ),
            );
          },
        ),
      );

      expect(find.text('Alpha'), findsOneWidget);
      expect(find.text('Beta'), findsOneWidget);
      expect(find.text('One'), findsNothing);

      // Tap to trigger state change and didUpdateWidget
      await tester.tap(find.text('Update'));
      await tester.pumpAndSettle();

      expect(find.text('One'), findsOneWidget);
      expect(find.text('Two'), findsOneWidget);
      expect(find.text('Three'), findsOneWidget);
      expect(find.text('Alpha'), findsNothing);
    },
  );

  test('WheelController handles out-of-bounds indices safely', () {
    final controller = WheelController<String>(
      options: ['A', 'B', 'C'],
      value: 'A',
      loop: false,
    );

    // Negative index should not throw
    expect(() => controller.handleIndexChanged(-5), returnsNormally);
    expect(controller.value, 'A');

    // Past end index should not throw
    expect(() => controller.handleIndexChanged(99), returnsNormally);
    expect(controller.value, 'A');

    // Negative index in loop mode wraps safely
    final loopController = WheelController<String>(
      options: ['A', 'B', 'C'],
      value: 'A',
      loop: true,
    );
    expect(() => loopController.handleIndexChanged(-1), returnsNormally);
    // -1 % 3 normalized is index 2 ('C')
    expect(loopController.value, 'C');
  });

  test('WheelController programmatic setOptions and setValue', () async {
    final controller = WheelController<int>(
      options: [10, 20, 30],
      value: 10,
    );

    expect(controller.value, 10);
    expect(controller.selectedIndex, 0);

    // Jump by value
    final res = controller.jumpToValue(30);
    expect(res, isTrue);
    expect(controller.value, 30);
    expect(controller.selectedIndex, 2);

    // Update options list
    controller.setOptions([100, 200, 300], alignToValue: false);
    expect(controller.options, [100, 200, 300]);
  });

  testWidgets(
    'WheelChoice with custom header extent centers overlay on wheel',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        _wrap(
          WheelChoice<String>(
            options: const ['A', 'B', 'C'],
            value: 'B',
            header: const WheelHeader(
              extent: 60,
              child: Text('Header 60px'),
            ),
            overlay: (_) => Container(key: const Key('overlay-box')),
          ),
        ),
      );

      final overlayBox = tester.getRect(find.byKey(const Key('overlay-box')));
      final wheelBox = tester.getRect(find.byType(ListWheelScrollView));

      // Overlay center must match wheel view vertical center
      expect(overlayBox.center.dy, equals(wheelBox.center.dy));
    },
  );

  testWidgets('WheelChoice handles empty options gracefully', (tester) async {
    await tester.pumpWidget(
      _wrap(
        const WheelChoice<String>(
          options: [],
        ),
      ),
    );

    expect(find.byType(WheelChoice<String>), findsOneWidget);
  });

  test('WheelController setValue respects notify: false', () async {
    int callCount = 0;
    final controller = WheelController<String>(
      options: ['A', 'B', 'C'],
      value: 'A',
      onChanged: (_) => callCount++,
    );

    await controller.setValue('B', notify: false);
    expect(controller.value, 'B');
    expect(callCount, 0);

    await controller.setValue('C', notify: true);
    expect(controller.value, 'C');
    expect(callCount, 1);
  });

  test(
    'WheelController initial value fallback to first item when not in options',
    () {
      final controller = WheelController<String>(
        options: ['First', 'Second'],
        value: 'Unknown',
      );

      expect(controller.value, 'First');
      expect(controller.selectedIndex, 0);
      expect(controller.valueListenable.value, 'First');
      expect(controller.indexListenable.value, 0);
    },
  );

  test(
    'WheelController setOptions resets to first item when old value is missing',
    () {
      final controller = WheelController<String>(
        options: ['Apple', 'Banana'],
        value: 'Banana',
      );

      expect(controller.value, 'Banana');
      expect(controller.selectedIndex, 1);

      controller.setOptions(['Cat', 'Dog', 'Bird']);

      expect(controller.value, 'Cat');
      expect(controller.selectedIndex, 0);
      expect(controller.valueListenable.value, 'Cat');
      expect(controller.indexListenable.value, 0);
    },
  );

  testWidgets('WheelChoice expanded mode preserves explicit itemExtent', (
    tester,
  ) async {
    await tester.pumpWidget(
      _wrap(
        SizedBox(
          height: 300,
          child: WheelChoice<String>(
            options: const ['One', 'Two', 'Three', 'Four', 'Five'],
            itemVisible: 5,
            itemExtent: 40.0,
            expanded: true,
          ),
        ),
      ),
    );

    final wheel = tester.widget<ListWheelScrollView>(
      find.byType(ListWheelScrollView),
    );
    expect(wheel.itemExtent, equals(40.0));
  });
}
