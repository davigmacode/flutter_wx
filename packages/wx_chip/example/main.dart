import 'package:flutter/material.dart';
import 'package:wx_chip/wx_chip.dart';

void main() {
  runApp(const WxChipExampleApp());
}

class WxChipExampleApp extends StatefulWidget {
  const WxChipExampleApp({super.key});

  @override
  State<WxChipExampleApp> createState() => _WxChipExampleAppState();
}

class _WxChipExampleAppState extends State<WxChipExampleApp> {
  final Set<String> _selectedFilters = {'Flutter', 'Dart'};
  final List<String> _tags = ['Flutter', 'Dart', 'Widgetarian', 'Mobile', 'Desktop', 'Web'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WxChip Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('WxChip Example'),
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Filter Chips (Tap to Toggle)',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.center,
                    children: _tags.map((tag) {
                      final isSelected = _selectedFilters.contains(tag);
                      return WxChip(
                        variant: isSelected ? WxChipVariant.tonal : WxChipVariant.outlined,
                        selected: isSelected,
                        onSelected: (val) {
                          setState(() {
                            if (val) {
                              _selectedFilters.add(tag);
                            } else {
                              _selectedFilters.remove(tag);
                            }
                          });
                        },
                        child: Text(tag),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Chip Variants',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.center,
                    children: [
                      WxChip(
                        variant: WxChipVariant.tonal,
                        leading: const Icon(Icons.star_rounded, size: 18),
                        child: const Text('Tonal'),
                        onPressed: () {},
                      ),
                      WxChip(
                        variant: WxChipVariant.filled,
                        leading: const Icon(Icons.bolt_rounded, size: 18),
                        child: const Text('Filled'),
                        onPressed: () {},
                      ),
                      WxChip(
                        variant: WxChipVariant.elevated,
                        leading: const Icon(Icons.layers_rounded, size: 18),
                        child: const Text('Elevated'),
                        onPressed: () {},
                      ),
                      WxChip(
                        variant: WxChipVariant.outlined,
                        leading: const Icon(Icons.crop_square_rounded, size: 18),
                        child: const Text('Outlined'),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
