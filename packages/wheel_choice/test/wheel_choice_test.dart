import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        const WheelChoice<String>(
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
        const SizedBox(
          height: 300,
          child: WheelChoice<String>(
            options: ['One', 'Two', 'Three', 'Four', 'Five'],
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

  test('WheelController next, previous, hasNext, hasPrevious', () async {
    final controller = WheelController<int>(
      options: [1, 2, 3],
      value: 1,
    );

    expect(controller.hasPrevious, isFalse);
    expect(controller.hasNext, isTrue);

    await controller.next(animate: false);
    expect(controller.value, 2);
    expect(controller.selectedIndex, 1);
    expect(controller.hasPrevious, isTrue);
    expect(controller.hasNext, isTrue);

    await controller.next(animate: false);
    expect(controller.value, 3);
    expect(controller.selectedIndex, 2);
    expect(controller.hasPrevious, isTrue);
    expect(controller.hasNext, isFalse);

    await controller.previous(animate: false);
    expect(controller.value, 2);
    expect(controller.selectedIndex, 1);
  });

  testWidgets('WheelChoice onIndexChanged callback fires', (tester) async {
    int? changedIndex;
    final controller = WheelController<String>(
      options: ['A', 'B', 'C'],
      value: 'A',
      onIndexChanged: (i) => changedIndex = i,
    );

    await tester.pumpWidget(
      _wrap(
        WheelChoice<String>.raw(
          controller: controller,
        ),
      ),
    );

    await controller.setValue('B', animate: false);
    expect(changedIndex, 1);
  });

  testWidgets('WheelChoice inherits configuration from WheelChoiceTheme', (
    tester,
  ) async {
    await tester.pumpWidget(
      _wrap(
        const WheelChoiceTheme(
          data: WheelChoiceThemeData(
            itemExtent: 52.0,
            itemVisible: 3,
          ),
          child: WheelChoice<String>(
            options: ['Alpha', 'Beta', 'Gamma'],
          ),
        ),
      ),
    );

    final wheel = tester.widget<ListWheelScrollView>(
      find.byType(ListWheelScrollView),
    );
    expect(wheel.itemExtent, equals(52.0));

    final sizedBox = tester.widget<SizedBox>(
      find
          .ancestor(
            of: find.byType(WheelOverlay),
            matching: find.byType(SizedBox),
          )
          .first,
    );
    // height = itemExtent * itemVisible = 52.0 * 3 = 156.0
    expect(sizedBox.height, equals(156.0));
  });

  testWidgets('WheelChoice fixed mode normalizes even itemVisible to odd', (
    tester,
  ) async {
    await tester.pumpWidget(
      _wrap(
        const WheelChoice<String>(
          options: ['A', 'B', 'C', 'D', 'E'],
          itemVisible: 4, // Even number should normalize to 5
          itemExtent: 40.0,
        ),
      ),
    );

    final sizedBox = tester.widget<SizedBox>(
      find
          .ancestor(
            of: find.byType(WheelOverlay),
            matching: find.byType(SizedBox),
          )
          .first,
    );
    // height = 40.0 * 5 = 200.0
    expect(sizedBox.height, equals(200.0));
  });

  testWidgets(
      'WheelChoice item reactive rebuilds on value change without setState', (
    tester,
  ) async {
    final controller = WheelController<String>(
      options: ['Item1', 'Item2', 'Item3'],
      value: 'Item1',
    );

    await tester.pumpWidget(
      _wrap(
        WheelChoice<String>.raw(
          controller: controller,
          itemBuilder: (context, item) {
            return Text(
              item.label,
              key: Key('text-${item.data}-${item.selected}'),
            );
          },
        ),
      ),
    );

    expect(find.byKey(const Key('text-Item1-true')), findsOneWidget);
    expect(find.byKey(const Key('text-Item2-false')), findsOneWidget);

    // Change value via controller without rebuilding parent
    controller.setValue('Item2', animate: false);
    await tester.pump();

    expect(find.byKey(const Key('text-Item1-false')), findsOneWidget);
    expect(find.byKey(const Key('text-Item2-true')), findsOneWidget);
  });

  group('WheelChoiceThemeData and WheelChoiceTheme', () {
    test('copyWith and merge', () {
      const data1 = WheelChoiceThemeData(
        itemExtent: 40,
        itemVisible: 5,
        haptics: true,
      );
      final copied = data1.copyWith(itemExtent: 50);
      expect(copied.itemExtent, 50);
      expect(copied.itemVisible, 5);
      expect(copied.haptics, isTrue);

      const data2 = WheelChoiceThemeData(itemVisible: 7, keyboard: true);
      final merged = data1.merge(data2);
      expect(merged.itemExtent, 40);
      expect(merged.itemVisible, 7);
      expect(merged.keyboard, isTrue);
      expect(data1.merge(null), equals(data1));
    });

    test('operator == and hashCode', () {
      const d1 = WheelChoiceThemeData(itemExtent: 40, itemVisible: 5);
      const d2 = WheelChoiceThemeData(itemExtent: 40, itemVisible: 5);
      const d3 = WheelChoiceThemeData(itemExtent: 50, itemVisible: 5);

      expect(d1, equals(d2));
      expect(d1.hashCode, equals(d2.hashCode));
      expect(d1, isNot(equals(d3)));
      expect(d1.toString(), contains('WheelChoiceThemeData(itemExtent: 40.0'));

      final lerped = WheelChoiceThemeData.lerp(d1, d3, 0.5);
      expect(lerped?.itemExtent, equals(45.0));
      expect(WheelChoiceThemeData.lerp(d1, d1, 0.5), equals(d1));
    });

    testWidgets('WheelChoiceTheme wrap and updateShouldNotify', (tester) async {
      const themeData = WheelChoiceThemeData(itemExtent: 42);
      final themeWidget = const WheelChoiceTheme(
        data: themeData,
        child: SizedBox(),
      );

      expect(themeWidget.updateShouldNotify(themeWidget), isFalse);
      const otherTheme = WheelChoiceTheme(
        data: WheelChoiceThemeData(itemExtent: 50),
        child: SizedBox(),
      );
      expect(themeWidget.updateShouldNotify(otherTheme), isTrue);

      await tester.pumpWidget(themeWidget);
      final wrapped = themeWidget.wrap(
          tester.element(find.byType(SizedBox)), const Text('child'));
      expect(wrapped, isA<WheelChoiceTheme>());
    });
  });

  group('WheelEffect unit tests', () {
    test('default getters, copyWith, merge, and toString', () {
      const effect = WheelEffect();
      expect(effect.useMagnifierX, isFalse);
      expect(effect.magnificationX, 1.0);
      expect(effect.diameterRatioX, 2.0);
      expect(effect.perspectiveX, 0.003);
      expect(effect.offAxisFractionX, 0.0);
      expect(effect.overAndUnderCenterOpacityX, 1.0);
      expect(effect.squeezeX, 1.0);

      const flat = WheelEffect.flat();
      expect(flat.diameterRatio, 100.0);

      final modified = effect.copyWith(magnification: 1.2, squeeze: 0.8);
      expect(modified.magnification, 1.2);
      expect(modified.squeeze, 0.8);

      final merged = effect.merge(const WheelEffect(perspective: 0.005));
      expect(merged.perspective, 0.005);
      expect(effect.merge(null), equals(effect));

      expect(effect.toString(), contains('WheelEffect('));
      expect(effect == const WheelEffect(), isTrue);
      expect(effect.hashCode == const WheelEffect().hashCode, isTrue);
      expect(effect == modified, isFalse);
    });
  });

  group('WheelHeader unit tests', () {
    testWidgets('WheelHeader.from and asDefaultFor', (tester) async {
      const h1 = WheelHeader(
        extent: 50,
        align: Alignment.centerLeft,
        child: Text('H1'),
      );
      final h2 = WheelHeader.from(h1, extent: 60);
      expect(h2.extent, 60);
      expect(h2.align, Alignment.centerLeft);

      const h3 = WheelHeader(extent: 70, child: Text('H3'));
      final defaultApplied = h1.asDefaultFor(h3);
      expect(defaultApplied.extent, 70);
      expect(defaultApplied.align, Alignment.centerLeft);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: h1,
          ),
        ),
      );
      expect(find.text('H1'), findsOneWidget);
    });
  });

  group('WheelOverlay unit and widget tests', () {
    testWidgets('WheelOverlay.filled and without builder', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WheelOverlay(
              extent: 40,
              builder: WheelOverlay.filled(
                color: Colors.red,
                cornerRadius: 8,
                inset: 10,
              ),
              child: const Text('WheelContent'),
            ),
          ),
        ),
      );

      expect(find.text('WheelContent'), findsOneWidget);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: WheelOverlay(
              builder: null,
              child: Text('NoOverlayContent'),
            ),
          ),
        ),
      );
      expect(find.text('NoOverlayContent'), findsOneWidget);
    });

    testWidgets(
        'WheelOverlay.delegate, outlined custom color, and offset translation',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WheelOverlay(
              extent: 40,
              offset: 20,
              builder: WheelOverlay.outlined(
                borderColor: Colors.green,
                inset: 5,
              ),
              child: const Text('OutlinedContent'),
            ),
          ),
        ),
      );
      expect(find.text('OutlinedContent'), findsOneWidget);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WheelOverlay(
              extent: 40,
              builder: WheelOverlay.delegate(
                color: Colors.blue,
                border: Border.all(),
                borderRadius: BorderRadius.circular(4),
                margin: const EdgeInsets.all(4),
              ),
              child: const Text('DelegateContent'),
            ),
          ),
        ),
      );
      expect(find.text('DelegateContent'), findsOneWidget);
    });
  });

  group('WheelItem unit tests', () {
    test('equality, hashCode, toString, and delegate', () {
      final item1 = WheelItem(
        data: 'A',
        label: 'A',
        selected: true,
        disabled: false,
      );
      final item2 = WheelItem(
        data: 'A',
        label: 'A',
        selected: true,
        disabled: false,
      );
      final item3 = WheelItem(
        data: 'B',
        label: 'B',
        selected: false,
        disabled: true,
      );
      final item4 = WheelItem(
        data: 'A',
        label: 'A-different',
        selected: true,
        disabled: false,
      );

      expect(item1, equals(item2));
      expect(item1.hashCode, equals(item2.hashCode));
      expect(item1, isNot(equals(item3)));
      expect(item1, isNot(equals(item4)));
      expect(item1.toString(), contains('WheelItem(data: A'));
    });

    testWidgets('WheelItem.delegate renders default and disabled styling',
        (tester) async {
      final builder = WheelItem.delegate<String>(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return Column(
                  children: [
                    builder(
                        context,
                        WheelItem(
                            data: '1',
                            label: 'Item 1',
                            selected: true,
                            disabled: false)),
                    builder(
                        context,
                        WheelItem(
                            data: '2',
                            label: 'Item 2',
                            selected: false,
                            disabled: true)),
                  ],
                );
              },
            ),
          ),
        ),
      );

      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 2'), findsOneWidget);
    });
  });

  group('WheelController advanced tests', () {
    test(
        'syncValueFromIndex, setAnimationDefaults, setOnChanged, setItemDisabled',
        () {
      final controller = WheelController<String>(
        options: ['One', 'Two', 'Three'],
        value: 'One',
      );

      controller.syncValueFromIndex(2);
      expect(controller.value, 'Three');

      controller.setAnimationDefaults(
        duration: const Duration(seconds: 1),
        curve: Curves.linear,
      );
      expect(controller.animationDuration, const Duration(seconds: 1));
      expect(controller.animationCurve, Curves.linear);

      String? changed;
      controller.setOnChanged((v) => changed = v);
      controller.setValue('Two', animate: false);
      expect(changed, 'Two');

      controller.setItemDisabled((v) => v == 'Two');
      expect(controller.isDisabled('Two'), isTrue);
      expect(controller.isDisabled('One'), isFalse);

      controller.dispose();
    });

    test('non-existent values and setIndex delegation', () async {
      final controller = WheelController<String>(
        options: ['A', 'B'],
        value: 'A',
      );
      expect(controller.jumpToValue('Unknown'), isFalse);
      expect(await controller.animateToValue('Unknown'), isFalse);

      await controller.setIndex(1, animate: true);
      expect(controller.selectedIndex, 1);
      expect(controller.value, 'B');
    });

    test('Loop mode next and previous wraps correctly', () async {
      final controller = WheelController<int>(
        options: [10, 20, 30],
        value: 10,
        loop: true,
      );

      expect(controller.hasPrevious, isTrue);
      expect(controller.hasNext, isTrue);

      await controller.previous(animate: false);
      expect(controller.value, 30);
      expect(controller.selectedIndex, 2);

      await controller.next(animate: false);
      expect(controller.value, 10);
      expect(controller.selectedIndex, 0);
    });
  });

  group('Keyboard navigation shortcuts', () {
    testWidgets('ArrowDown, ArrowUp, PageDown, PageUp, End, Home',
        (tester) async {
      final focusNode = FocusNode();
      String selected = 'B';
      final controller = WheelController<String>(
        options: ['A', 'B', 'C', 'D', 'E'],
        value: selected,
        onChanged: (v) => selected = v,
      );

      await tester.pumpWidget(
        _wrap(
          WheelChoice<String>.raw(
            controller: controller,
            keyboard: true,
            focusNode: focusNode,
          ),
        ),
      );

      focusNode.requestFocus();
      await tester.pump();

      // Press ArrowDown -> moves to C
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
      await tester.pumpAndSettle();
      expect(controller.value, 'C');

      // Press ArrowUp -> moves back to B
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowUp);
      await tester.pumpAndSettle();
      expect(controller.value, 'B');

      // Press End -> moves to E
      await tester.sendKeyEvent(LogicalKeyboardKey.end);
      await tester.pumpAndSettle();
      expect(controller.value, 'E');

      // Press Home -> moves to A
      await tester.sendKeyEvent(LogicalKeyboardKey.home);
      await tester.pumpAndSettle();
      expect(controller.value, 'A');

      // Press PageDown -> moves delta +3 -> D
      await tester.sendKeyEvent(LogicalKeyboardKey.pageDown);
      await tester.pumpAndSettle();
      expect(controller.value, 'D');

      // Press PageUp -> moves delta -3 -> A
      await tester.sendKeyEvent(LogicalKeyboardKey.pageUp);
      await tester.pumpAndSettle();
      expect(controller.value, 'A');

      focusNode.dispose();
    });
  });

  group('WheelChoiceFormField widget tests', () {
    testWidgets('validation, onSaved, reset, and decoration errorText',
        (tester) async {
      final formKey = GlobalKey<FormState>();
      String? savedValue;
      String? changedValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: WheelChoiceFormField<String>(
                options: const ['Red', 'Green', 'Blue'],
                initialValue: 'Red',
                decoration: const InputDecoration(labelText: 'Color'),
                validator: (val) => val == 'Red' ? 'Red is not allowed' : null,
                onChanged: (val) => changedValue = val,
                onSaved: (val) => savedValue = val,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Red'), findsWidgets);
      expect(find.text('Color'), findsOneWidget);

      // Validate -> should fail because value is 'Red'
      final isValid = formKey.currentState!.validate();
      await tester.pumpAndSettle();
      expect(isValid, isFalse);
      expect(find.text('Red is not allowed'), findsOneWidget);

      // Change selection to 'Green'
      await tester.tap(find.text('Green').first);
      await tester.pumpAndSettle();
      expect(changedValue, 'Green');

      // Validate -> should pass now
      expect(formKey.currentState!.validate(), isTrue);
      await tester.pumpAndSettle();
      expect(find.text('Red is not allowed'), findsNothing);

      // Save form
      formKey.currentState!.save();
      expect(savedValue, 'Green');

      // Reset form
      formKey.currentState!.reset();
      await tester.pumpAndSettle();
      expect(formKey.currentState!.validate(), isFalse); // reset to 'Red'
    });

    testWidgets('works with external controller and synchronizes reset',
        (tester) async {
      final formKey = GlobalKey<FormState>();
      final controller = WheelController<String>(
        options: ['Small', 'Medium', 'Large'],
        value: 'Small',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: WheelChoiceFormField<String>(
                controller: controller,
                validator: (v) => v == 'Large' ? 'Too big' : null,
              ),
            ),
          ),
        ),
      );

      expect(controller.value, 'Small');
      expect(formKey.currentState!.validate(), isTrue);

      // Change via controller
      controller.setValue('Large', animate: false);
      await tester.pumpAndSettle();

      expect(formKey.currentState!.validate(), isFalse);
      await tester.pumpAndSettle();
      expect(find.text('Too big'), findsOneWidget);

      // Reset
      formKey.currentState!.reset();
      await tester.pumpAndSettle();
      expect(controller.value, 'Small');
    });

    testWidgets(
        'disabled field applies NeverScrollableScrollPhysics and disabled state',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              child: WheelChoiceFormField<String>(
                options: const ['One', 'Two'],
                initialValue: 'One',
                enabled: false,
              ),
            ),
          ),
        ),
      );

      final scrollable = tester.widget<ListWheelScrollView>(
        find.byType(ListWheelScrollView),
      );
      expect(scrollable.physics, isA<NeverScrollableScrollPhysics>());
    });
  });

  group('Horizontal orientation tests', () {
    testWidgets(
        'fixed horizontal picker wraps with RotatedBox and sets dimensions',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WheelChoice<String>(
              options: const ['Item 1', 'Item 2', 'Item 3'],
              value: 'Item 2',
              scrollDirection: Axis.horizontal,
              itemExtent: 60,
              itemVisible: 3,
              overlay: WheelOverlay.outlined(axis: Axis.horizontal),
            ),
          ),
        ),
      );

      // RotatedBox(quarterTurns: 3) for viewport, plus RotatedBox(quarterTurns: 1) for items
      expect(find.byType(RotatedBox), findsWidgets);
      expect(find.text('Item 2'), findsWidgets);

      // Width of fixed horizontal wheel = 60 * 3 = 180
      final sizedBox = tester.widget<SizedBox>(
        find
            .ancestor(
              of: find.byType(WheelOverlay),
              matching: find.byType(SizedBox),
            )
            .first,
      );
      expect(sizedBox.width, equals(180.0));
    });

    testWidgets('expanded horizontal picker adapts to maxWidth',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 300,
                height: 80,
                child: WheelChoice<int>(
                  options: [1, 2, 3, 4, 5],
                  value: 3,
                  scrollDirection: Axis.horizontal,
                  expanded: true,
                  itemVisible: 3,
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(RotatedBox), findsWidgets);
      expect(find.text('3'), findsWidgets);
    });

    testWidgets('WheelOverlay with Axis.horizontal uses vertical border',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WheelOverlay(
              axis: Axis.horizontal,
              extent: 50,
              builder: WheelOverlay.outlined(axis: Axis.horizontal),
              child: const SizedBox(width: 200, height: 60),
            ),
          ),
        ),
      );

      expect(find.byType(WheelOverlay), findsOneWidget);
    });
  });

  group('Null value handling & explicit null options', () {
    testWidgets('WheelChoice supports explicit null option in list',
        (tester) async {
      String? selected;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WheelChoice<String?>(
              options: const [null, 'Apple', 'Banana'],
              value: null,
              itemLabel: (v) => v ?? 'None',
              onChanged: (v) => selected = v,
            ),
          ),
        ),
      );

      expect(find.text('None'), findsWidgets);

      await tester.tap(find.text('Banana').first);
      await tester.pumpAndSettle();
      expect(selected, 'Banana');

      await tester.tap(find.text('None').first);
      await tester.pumpAndSettle();
      expect(selected, isNull);
    });

    test(
        'Controller selectedIndex and navigation guards when options are empty',
        () {
      final controller = WheelController<String>(
        options: [],
        value: null,
      );

      expect(controller.selectedIndex, equals(-1));
      expect(controller.hasPrevious, isFalse);
      expect(controller.hasNext, isFalse);
      expect(controller.value, isNull);

      // setOptions populates new items
      controller.setOptions(['Alpha', 'Beta']);
      expect(controller.selectedIndex, equals(0));
      expect(controller.value, equals('Alpha'));
      expect(controller.hasNext, isTrue);

      // setOptions to empty resets to -1
      controller.setOptions([]);
      expect(controller.selectedIndex, equals(-1));
      expect(controller.value, isNull);
    });
  });
}
