import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widget_event/widget_event.dart';

// Custom event extension for testing
class CustomEvent extends WidgetEvent {
  const CustomEvent(super.value);

  static const verifying = CustomEvent('verifying');
  static const expired = CustomEvent('expired');

  static bool isVerifying(Set<WidgetEvent> events) => events.contains(verifying);
}

// Test widget utilizing WidgetEventMixin
class MixinTestWidget extends StatefulWidget {
  const MixinTestWidget({super.key, this.eventsController});

  final WidgetEventController? eventsController;

  @override
  State<MixinTestWidget> createState() => _MixinTestWidgetState();
}

class _MixinTestWidgetState extends State<MixinTestWidget> with WidgetEventMixin<MixinTestWidget> {
  @override
  void initState() {
    super.initState();
    initWidgetEvents(widget.eventsController);
  }

  @override
  void didUpdateWidget(covariant MixinTestWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    updateWidgetEvents(widget.eventsController);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widgetEvents.isPressed
          ? Colors.red
          : (widgetEvents.isHovered ? Colors.blue : Colors.grey),
      child: Text('Hover: ${widgetEvents.isHovered}, Press: ${widgetEvents.isPressed}'),
    );
  }
}

void main() {
  group('WidgetEvent Core Tests', () {
    test('Standard constants have expected names and toString', () {
      expect(WidgetEvent.hovered.value, equals('hovered'));
      expect(WidgetEvent.focused.value, equals('focused'));
      expect(WidgetEvent.pressed.value, equals('pressed'));
      expect(WidgetEvent.dragged.value, equals('dragged'));
      expect(WidgetEvent.selected.value, equals('selected'));
      expect(WidgetEvent.indeterminate.value, equals('indeterminate'));
      expect(WidgetEvent.disabled.value, equals('disabled'));
      expect(WidgetEvent.error.value, equals('error'));
      expect(WidgetEvent.loading.value, equals('loading'));

      expect(WidgetEvent.hovered.toString(), equals('WidgetEvent.hovered'));
    });

    test('Equality and HashCode work correctly', () {
      const e1 = WidgetEvent('hovered');
      const e2 = WidgetEvent.hovered;
      const e3 = WidgetEvent('pressed');

      expect(e1, equals(e2));
      expect(e1.hashCode, equals(e2.hashCode));
      expect(e1, isNot(equals(e3)));
    });

    test('Custom WidgetEvent extension behaves cleanly', () {
      const custom = CustomEvent.verifying;
      expect(custom.value, equals('verifying'));
      expect(CustomEvent.isVerifying({custom}), isTrue);
      expect(CustomEvent.isVerifying({WidgetEvent.loading}), isFalse);
    });

    test('Static checker helpers accurately detect active states', () {
      final events = <WidgetEvent>{
        WidgetEvent.hovered,
        WidgetEvent.focused,
        WidgetEvent.pressed,
        WidgetEvent.dragged,
        WidgetEvent.selected,
        WidgetEvent.indeterminate,
        WidgetEvent.disabled,
        WidgetEvent.error,
        WidgetEvent.loading,
      };

      expect(WidgetEvent.isHovered(events), isTrue);
      expect(WidgetEvent.isFocused(events), isTrue);
      expect(WidgetEvent.isPressed(events), isTrue);
      expect(WidgetEvent.isDragged(events), isTrue);
      expect(WidgetEvent.isSelected(events), isTrue);
      expect(WidgetEvent.isIndeterminate(events), isTrue);
      expect(WidgetEvent.isDisabled(events), isTrue);
      expect(WidgetEvent.isErrored(events), isTrue);
      expect(WidgetEvent.isLoading(events), isTrue);

      final empty = <WidgetEvent>{};
      expect(WidgetEvent.isHovered(empty), isFalse);
      expect(WidgetEvent.isPressed(empty), isFalse);
      expect(WidgetEvent.isLoading(empty), isFalse);
    });
  });

  group('WidgetEventController Tests', () {
    test('Constructors initialize properly', () {
      final c1 = WidgetEventController();
      expect(c1.value.isEmpty, isTrue);

      final c2 = WidgetEventController.value({WidgetEvent.hovered});
      expect(c2.isHovered, isTrue);

      final c3 = WidgetEventController.by(hovered: true, pressed: true);
      expect(c3.isHovered, isTrue);
      expect(c3.isPressed, isTrue);
      expect(c3.isSelected, isFalse);

      final c4 = WidgetEventController.reg({
        WidgetEvent.disabled: true,
        WidgetEvent.selected: false,
      });
      expect(c4.isDisabled, isTrue);
      expect(c4.isSelected, isFalse);

      c1.dispose();
      c2.dispose();
      c3.dispose();
      c4.dispose();
    });

    test('add, remove, toggle, replace, merge modify state and notify listeners', () {
      final controller = WidgetEventController();
      int notifyCount = 0;
      controller.addListener(() => notifyCount++);

      controller.add(WidgetEvent.hovered);
      expect(controller.value.contains(WidgetEvent.hovered), isTrue);
      expect(notifyCount, equals(1));

      // Adding existing event should not notify
      controller.add(WidgetEvent.hovered);
      expect(notifyCount, equals(1));

      // Toggle off
      controller.toggle(WidgetEvent.hovered, false);
      expect(controller.value.contains(WidgetEvent.hovered), isFalse);
      expect(notifyCount, equals(2));

      // Toggle on
      controller.toggle(WidgetEvent.pressed, true);
      expect(controller.value.contains(WidgetEvent.pressed), isTrue);
      expect(notifyCount, equals(3));

      // Toggle flip (null active parameter)
      controller.toggle(WidgetEvent.pressed);
      expect(controller.value.contains(WidgetEvent.pressed), isFalse);
      expect(notifyCount, equals(4));

      // Replace batch
      controller.replace({WidgetEvent.loading, WidgetEvent.selected});
      expect(controller.value, equals({WidgetEvent.loading, WidgetEvent.selected}));
      expect(notifyCount, equals(5));

      // Merge
      controller.merge({WidgetEvent.error});
      expect(controller.value.contains(WidgetEvent.error), isTrue);
      expect(notifyCount, equals(6));

      // Clear
      controller.clear();
      expect(controller.value.isEmpty, isTrue);
      expect(notifyCount, equals(7));

      controller.dispose();
    });

    test('update method preserves unmentioned states and updates booleans', () {
      final controller = WidgetEventController({WidgetEvent.disabled});
      
      controller.update({
        WidgetEvent.hovered: true,
        WidgetEvent.pressed: false,
        WidgetEvent.loading: true,
      });

      expect(controller.value.contains(WidgetEvent.disabled), isTrue);
      expect(controller.value.contains(WidgetEvent.hovered), isTrue);
      expect(controller.value.contains(WidgetEvent.loading), isTrue);
      expect(controller.value.contains(WidgetEvent.pressed), isFalse);

      controller.dispose();
    });

    test('emit returns a ValueSetter callback', () {
      final controller = WidgetEventController();
      final emitter = controller.emit(WidgetEvent.hovered);

      emitter(true);
      expect(controller.isHovered, isTrue);

      emitter(false);
      expect(controller.isHovered, isFalse);

      controller.dispose();
    });
  });

  group('DrivenProperty Tests', () {
    test('DrivenProperty.by resolves based on event set', () {
      final colorProp = DrivenProperty.by<Color>((events) {
        if (WidgetEvent.isPressed(events)) return Colors.red;
        if (WidgetEvent.isHovered(events)) return Colors.blue;
        return Colors.green;
      });

      expect(colorProp.resolve({WidgetEvent.pressed}), equals(Colors.red));
      expect(colorProp.resolve({WidgetEvent.hovered}), equals(Colors.blue));
      expect(colorProp.resolve({}), equals(Colors.green));
    });

    test('DrivenProperty.evaluate handles non-driven and driven values', () {
      const fixedColor = Colors.purple;
      expect(DrivenProperty.evaluate<Color>(fixedColor, {WidgetEvent.pressed}), equals(Colors.purple));

      final Object driven = DrivenProperty.all<int>(42);
      expect(DrivenProperty.evaluate<Object?>(driven, {}), equals(42));
    });

    test('DrivenColor behaves as a Color and DrivenProperty', () {
      final drivenColor = DrivenColor.by((events) {
        if (WidgetEvent.isPressed(events)) return Colors.red;
        return Colors.teal;
      });

      expect(drivenColor.resolve({WidgetEvent.pressed}), equals(Colors.red));
      expect(drivenColor.resolve({}), equals(Colors.teal));

      final evaluated = DrivenColor.evaluate(drivenColor, {WidgetEvent.pressed});
      expect(evaluated, equals(Colors.red));
    });
  });

  group('Driven Widgets & Components Tests', () {
    test('DrivenSpinner resolves atLoading state', () {
      const spinner = DrivenSpinner(size: 24, color: Colors.blue);
      expect(spinner.resolve({}), isNull);
      expect(spinner.resolve({WidgetEvent.loading}), isNotNull);
    });

    test('DrivenChild resolves different children based on events', () {
      const driven = DrivenChild<Widget?>(
        Text('Default'),
        atPressed: Text('Pressed'),
        atLoading: Text('Loading'),
      );

      final defaultWidget = driven.resolve({}) as Text;
      expect(defaultWidget.data, equals('Default'));

      final pressedWidget = driven.resolve({WidgetEvent.pressed}) as Text;
      expect(pressedWidget.data, equals('Pressed'));

      final loadingWidget = driven.resolve({WidgetEvent.loading}) as Text;
      expect(loadingWidget.data, equals('Loading'));
    });

    testWidgets('WidgetEventMixin responds to controller changes and triggers rebuild', (tester) async {
      final controller = WidgetEventController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MixinTestWidget(eventsController: controller),
          ),
        ),
      );

      expect(find.text('Hover: false, Press: false'), findsOneWidget);

      controller.toggle(WidgetEvent.hovered, true);
      await tester.pump();
      expect(find.text('Hover: true, Press: false'), findsOneWidget);

      controller.toggle(WidgetEvent.pressed, true);
      await tester.pump();
      expect(find.text('Hover: true, Press: true'), findsOneWidget);

      controller.dispose();
    });
  });

  group('WidgetState Bridge Tests', () {
    test('Converts individual WidgetEvent <-> WidgetState accurately', () {
      expect(WidgetEvent.hovered.toWidgetState(), equals(WidgetState.hovered));
      expect(WidgetEvent.focused.toWidgetState(), equals(WidgetState.focused));
      expect(WidgetEvent.pressed.toWidgetState(), equals(WidgetState.pressed));
      expect(WidgetEvent.dragged.toWidgetState(), equals(WidgetState.dragged));
      expect(WidgetEvent.selected.toWidgetState(), equals(WidgetState.selected));
      expect(WidgetEvent.disabled.toWidgetState(), equals(WidgetState.disabled));
      expect(WidgetEvent.error.toWidgetState(), equals(WidgetState.error));

      // Custom or unmapped events return null
      expect(WidgetEvent.loading.toWidgetState(), isNull);
      expect(WidgetEvent.indeterminate.toWidgetState(), isNull);
      expect(const WidgetEvent('custom').toWidgetState(), isNull);

      // From WidgetState
      expect(WidgetState.hovered.toWidgetEvent(), equals(WidgetEvent.hovered));
      expect(WidgetState.pressed.toWidgetEvent(), equals(WidgetEvent.pressed));
      expect(WidgetState.disabled.toWidgetEvent(), equals(WidgetEvent.disabled));
    });

    test('Set<WidgetEvent> <-> Set<WidgetState> batch conversion works', () {
      final events = {WidgetEvent.hovered, WidgetEvent.loading, WidgetEvent.pressed};
      final states = events.toWidgetStates();
      expect(states, equals({WidgetState.hovered, WidgetState.pressed}));

      final backToEvents = states.toWidgetEvents();
      expect(backToEvents, equals({WidgetEvent.hovered, WidgetEvent.pressed}));
    });

    test('Two-way real-time controller bridge synchronizes states', () {
      final eventController = WidgetEventController({WidgetEvent.disabled, WidgetEvent.loading});
      final statesController = WidgetEventStatesBridge.toWidgetStatesController(eventController);

      expect(statesController.value, equals({WidgetState.disabled}));

      // Mutate from WidgetEventController
      eventController.add(WidgetEvent.pressed);
      expect(statesController.value, equals({WidgetState.disabled, WidgetState.pressed}));

      // Mutate from native WidgetStatesController
      statesController.update(WidgetState.hovered, true);
      expect(eventController.value.contains(WidgetEvent.hovered), isTrue);
      // Ensure loading state was preserved during native sync
      expect(eventController.value.contains(WidgetEvent.loading), isTrue);

      eventController.dispose();
      statesController.dispose();
    });

    test('DrivenProperty adapts to native WidgetStateProperty seamlessly', () {
      final driven = DrivenProperty.by<Color>((events) {
        if (WidgetEvent.isPressed(events)) return Colors.red;
        if (WidgetEvent.isHovered(events)) return Colors.blue;
        return Colors.green;
      });

      final nativeProperty = driven.toWidgetStateProperty();
      expect(nativeProperty.resolve({WidgetState.pressed}), equals(Colors.red));
      expect(nativeProperty.resolve({WidgetState.hovered}), equals(Colors.blue));
      expect(nativeProperty.resolve({}), equals(Colors.green));
    });
  });
}
