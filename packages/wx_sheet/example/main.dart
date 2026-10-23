import 'package:flutter/material.dart';
import 'package:wx_sheet/wx_sheet.dart';

void main() {
  runApp(const WxSheetExampleApp());
}

class WxSheetExampleApp extends StatefulWidget {
  const WxSheetExampleApp({super.key});

  @override
  State<WxSheetExampleApp> createState() => _WxSheetExampleAppState();
}

class _WxSheetExampleAppState extends State<WxSheetExampleApp> {
  bool _selected = false;
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MaterialApp(
      title: 'WxSheet Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('WxSheet Demo')),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Static Sheets', style: theme.textTheme.titleMedium),
                const SizedBox(height: 12),
                const Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    WxStaticSheet(
                      width: 90,
                      height: 90,
                      variant: WxSheetVariant.tonal,
                      alignment: Alignment.center,
                      child: Text('Tonal'),
                    ),
                    WxStaticSheet(
                      width: 90,
                      height: 90,
                      variant: WxSheetVariant.elevated,
                      alignment: Alignment.center,
                      child: Text('Elevated'),
                    ),
                    WxStaticSheet(
                      width: 90,
                      height: 90,
                      variant: WxSheetVariant.filled,
                      alignment: Alignment.center,
                      child: Text('Filled'),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Text('Tap Sheet (Clickable)', style: theme.textTheme.titleMedium),
                const SizedBox(height: 12),
                WxTapSheet(
                  onPressed: () => setState(() => _counter++),
                  variant: WxSheetVariant.tonal,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.touch_app_rounded),
                      const SizedBox(width: 8),
                      Text('Tapped $_counter times'),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Text('Toggle Sheet (Selectable with Checkmark)', style: theme.textTheme.titleMedium),
                const SizedBox(height: 12),
                WxToggleSheet(
                  selected: _selected,
                  onSelected: (val) => setState(() => _selected = val),
                  variant: WxSheetVariant.outlined,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: const Text('Toggle Selection'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
