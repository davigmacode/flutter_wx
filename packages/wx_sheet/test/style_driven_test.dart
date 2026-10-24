import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wx_sheet/wx_sheet.dart';
import 'package:wx_sheet/wx_event.dart';

void main() {
  group('WxSheetStyle Polymorphic Driven Tests', () {
    test('Static style resolves to itself with zero allocation', () {
      const staticStyle = WxSheetStyle(
        backgroundColor: Colors.blue,
        padding: EdgeInsets.all(12),
      );

      expect(staticStyle.isDriven, isFalse);
      expect(staticStyle.resolve({}), same(staticStyle));
      expect(
        staticStyle.resolve({WxSheetEvent.hovered, WxSheetEvent.pressed}),
        same(staticStyle),
      );
    });

    test('WxSheetStyle.driven resolves event-specific slots', () {
      final drivenStyle = WxSheetStyle.driven(
        base: const WxSheetStyle(backgroundColor: Colors.blue),
        hovered: const WxSheetStyle(backgroundColor: Colors.cyan),
        pressed: const WxSheetStyle(backgroundColor: Colors.indigo, scale: 0.95),
        disabled: const WxSheetStyle(opacity: 0.5),
      );

      expect(drivenStyle.isDriven, isTrue);

      // Default state
      final defaultResolved = drivenStyle.resolve({});
      expect(defaultResolved.backgroundColor, Colors.blue);
      expect(defaultResolved.scale, isNull);

      // Hovered
      final hoveredResolved = drivenStyle.resolve({WxSheetEvent.hovered});
      expect(hoveredResolved.backgroundColor, Colors.cyan);

      // Pressed (takes precedence or merges with pressed)
      final pressedResolved = drivenStyle.resolve({WxSheetEvent.pressed});
      expect(pressedResolved.backgroundColor, Colors.indigo);
      expect(pressedResolved.scale, 0.95);

      // Disabled
      final disabledResolved = drivenStyle.resolve({WxSheetEvent.disabled});
      expect(disabledResolved.opacity, 0.5);
    });

    test('WxSheetStyle.resolveWith resolves dynamic closure logic', () {
      final dynamicStyle = WxSheetStyle.resolveWith((events) {
        if (events.contains(WxSheetEvent.pressed)) {
          return const WxSheetStyle(scale: 0.9);
        }
        if (events.contains(WxSheetEvent.hovered)) {
          return const WxSheetStyle(scale: 1.05);
        }
        return const WxSheetStyle(scale: 1.0);
      });

      expect(dynamicStyle.isDriven, isTrue);
      expect(dynamicStyle.resolve({}).scale, 1.0);
      expect(dynamicStyle.resolve({WxSheetEvent.hovered}).scale, 1.05);
      expect(dynamicStyle.resolve({WxSheetEvent.pressed}).scale, 0.9);
    });

    test('Merging static and driven styles produces responsive dynamic style', () {
      const themeBase = WxSheetStyle(
        backgroundColor: Colors.white,
        padding: EdgeInsets.all(16),
      );

      final localDriven = WxSheetStyle.driven(
        hovered: const WxSheetStyle(backgroundColor: Colors.amber),
      );

      final merged = themeBase.merge(localDriven);
      expect(merged.isDriven, isTrue);

      // Empty events should preserve base padding and base color
      final baseResolved = merged.resolve({});
      expect(baseResolved.backgroundColor, Colors.white);
      expect(baseResolved.padding, const EdgeInsets.all(16));

      // Hovered event should keep padding from theme and take amber from local
      final hoveredResolved = merged.resolve({WxSheetEvent.hovered});
      expect(hoveredResolved.backgroundColor, Colors.amber);
      expect(hoveredResolved.padding, const EdgeInsets.all(16));
    });

    test('Merging two driven styles combines their respective event handlers', () {
      final themeDriven = WxSheetStyle.driven(
        base: const WxSheetStyle(backgroundColor: Colors.white),
        hovered: const WxSheetStyle(backgroundColor: Colors.grey),
        focused: const WxSheetStyle(elevation: 4),
      );

      final localDriven = WxSheetStyle.driven(
        hovered: const WxSheetStyle(foregroundColor: Colors.red),
      );

      final combined = themeDriven.merge(localDriven);

      final hoveredResolved = combined.resolve({WxSheetEvent.hovered});
      // Theme gave grey background, local gave red foreground
      expect(hoveredResolved.backgroundColor, Colors.grey);
      expect(hoveredResolved.foregroundColor, Colors.red);

      // Focus retains elevation 4 from theme
      final focusedResolved = combined.resolve({WxSheetEvent.focused});
      expect(focusedResolved.elevation, 4);
    });

    test('WxColor semantic constants and DrivenColor behave as expected', () {
      expect(WxColor.primary, isA<Color>());
      expect(WxColor.danger, isA<Color>());
      expect(WxColor.success, isA<Color>());

      final drivenColor = WxColor.resolveWith((events) {
        if (events.contains(WidgetEvent.hovered)) {
          return WxColor.danger;
        }
        return WxColor.primary;
      });

      expect(drivenColor.resolve({}), WxColor.primary);
      expect(drivenColor.resolve({WidgetEvent.hovered}), WxColor.danger);
    });
  });
}
