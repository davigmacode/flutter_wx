import 'package:flutter/material.dart';
import 'package:widgetarian/widgetarian.dart';
import '../widgets/showcase_scaffold.dart';

class ChoiceShowcase extends StatefulWidget {
  const ChoiceShowcase({super.key});

  @override
  State<ChoiceShowcase> createState() => _ChoiceShowcaseState();
}

class _ChoiceShowcaseState extends State<ChoiceShowcase> {
  String? _singleChoice = 'Flutter';
  List<String> _multiChoice = ['Dart', 'Widgetarian'];

  final List<String> _options = [
    'Flutter',
    'Dart',
    'Widgetarian',
    'Android',
    'iOS',
    'Web',
    'macOS',
    'Windows',
    'Linux',
  ];

  @override
  Widget build(BuildContext context) {
    return ShowcaseScaffold(
      packageName: 'choice',
      version: '2.3.3',
      description:
          'Next-gen selection framework. Successor to smart_select and chips_choice with composable inline chips, modal dialogs, bottom sheets, and multi-selection.',
      children: [
        ShowcaseCard(
          title: 'Inline Single Selection',
          subtitle: 'Select one item from composable chips with wrapped layout.',
          codeSnippet: '''
InlineChoice<String>.single(
  value: _singleChoice,
  onChanged: (val) => setState(() => _singleChoice = val),
  itemCount: options.length,
  itemBuilder: (state, i) {
    return ChoiceChip(
      selected: state.selected(options[i]),
      onSelected: state.onSelected(options[i]),
      label: Text(options[i]),
    );
  },
  listBuilder: ChoiceList.createWrapped(spacing: 8, runSpacing: 8),
)''',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InlineChoice<String>.single(
                value: _singleChoice,
                onChanged: (val) => setState(() => _singleChoice = val),
                itemCount: _options.length,
                itemBuilder: (state, i) {
                  return ChoiceChip(
                    selected: state.selected(_options[i]),
                    onSelected: state.onSelected(_options[i]),
                    label: Text(_options[i]),
                  );
                },
                listBuilder: ChoiceList.createWrapped(spacing: 8, runSpacing: 8),
              ),
              const SizedBox(height: 12),
              Text(
                'Selected: ${_singleChoice ?? "None"}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        ShowcaseCard(
          title: 'Inline Multiple Selection',
          subtitle: 'Select multiple items seamlessly with wrapped layout.',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InlineChoice<String>.multiple(
                value: _multiChoice,
                onChanged: (val) => setState(() => _multiChoice = val),
                itemCount: _options.length,
                itemBuilder: (state, i) {
                  return FilterChip(
                    selected: state.selected(_options[i]),
                    onSelected: state.onSelected(_options[i]),
                    label: Text(_options[i]),
                  );
                },
                listBuilder: ChoiceList.createWrapped(spacing: 8, runSpacing: 8),
              ),
              const SizedBox(height: 12),
              Text(
                'Selected: ${_multiChoice.join(", ")}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class WheelChoiceShowcase extends StatefulWidget {
  const WheelChoiceShowcase({super.key});

  @override
  State<WheelChoiceShowcase> createState() => _WheelChoiceShowcaseState();
}

class _WheelChoiceShowcaseState extends State<WheelChoiceShowcase> {
  int _selectedValue = 24;

  @override
  Widget build(BuildContext context) {
    return ShowcaseScaffold(
      packageName: 'wheel_choice',
      version: '1.3.0',
      description:
          'Highly customizable 3D cylindrical wheel picker. Features perspective projection, magnification lens, infinite looping, and smooth inertial scroll physics.',
      children: [
        ShowcaseCard(
          title: '3D Cylinder Picker with Magnification',
          subtitle: 'Scroll vertically to select integer values with haptic-like inertial physics.',
          codeSnippet: '''
WheelChoice<int>(
  value: _selectedValue,
  options: List.generate(60, (index) => index + 1),
  onChanged: (val) => setState(() => _selectedValue = val),
)''',
          child: Column(
            children: [
              SizedBox(
                height: 150,
                child: WheelChoice<int>(
                  value: _selectedValue,
                  options: List.generate(60, (index) => index + 1),
                  onChanged: (val) => setState(() => _selectedValue = val),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Chosen Value: $_selectedValue units',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class WheelChoiceExtShowcase extends StatefulWidget {
  const WheelChoiceExtShowcase({super.key});

  @override
  State<WheelChoiceExtShowcase> createState() => _WheelChoiceExtShowcaseState();
}

class _WheelChoiceExtShowcaseState extends State<WheelChoiceExtShowcase> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return ShowcaseScaffold(
      packageName: 'wheel_choice_ext',
      version: '0.1.0',
      description:
          'Extensions for wheel_choice providing multi-column cascading pickers, locale-aware date pickers (YMD, DMY, MDY), time pickers, and FormField integration.',
      children: [
        ShowcaseCard(
          title: 'Cascading Date Picker Wheel',
          subtitle: 'Wheel date picker with day, month, and year synchronized columns.',
          codeSnippet: '''
WheelDateChoice(
  value: _selectedDate,
  onChanged: (date) => setState(() => _selectedDate = date),
)''',
          child: Column(
            children: [
              SizedBox(
                height: 160,
                child: WheelDateChoice(
                  value: _selectedDate,
                  onChanged: (date) => setState(() => _selectedDate = date),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Selected Date: ${_selectedDate.toLocal().toString().split(" ")[0]}',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DisclosureShowcase extends StatelessWidget {
  const DisclosureShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return const ShowcaseScaffold(
      packageName: 'disclosure',
      version: '2.2.0',
      description:
          'Headless, accessible collapsible accordion and disclosure pattern with smooth height expansion and custom headers.',
      children: [
        ShowcaseCard(
          title: 'Accordion Section',
          subtitle: 'Expandable tile with animated chevron and body transition.',
          codeSnippet: '''
DisclosureTile(
  title: Text('What is Widgetarian?'),
  children: [
    Text('Widgetarian is an open-source, unified Flutter UI toolkit...'),
  ],
)''',
          child: Column(
            children: [
              DisclosureTile(
                title: Text('What is Widgetarian?', style: TextStyle(fontWeight: FontWeight.bold)),
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Text(
                      'Widgetarian is an open-source, unified Flutter UI toolkit that consolidates animation primitives, typography, selection controls, layout utilities, and micro-interactions into a single modular ecosystem.',
                      style: TextStyle(height: 1.5),
                    ),
                  ),
                ],
              ),
              Divider(height: 1),
              DisclosureTile(
                title: Text('Is it production-ready?', style: TextStyle(fontWeight: FontWeight.bold)),
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Text(
                      'Yes! Every package in the repository is tested with 100% pass rates, zero analyzer warnings under strict flutter_lints v5, and full compatibility with Flutter 3.24+.',
                      style: TextStyle(height: 1.5),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
