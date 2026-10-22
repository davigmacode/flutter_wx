import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:wheel_choice/wheel_choice.dart';

void main() => runApp(const WheelChoiceExampleApp());

class WheelChoiceExampleApp extends StatelessWidget {
  const WheelChoiceExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'wheel_choice example',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
          PointerDeviceKind.stylus,
          PointerDeviceKind.trackpad,
        },
      ),
      home: const ExampleHomePage(),
    );
  }
}

class ExampleHomePage extends StatefulWidget {
  const ExampleHomePage({super.key});

  @override
  State<ExampleHomePage> createState() => _ExampleHomePageState();
}

class _ExampleHomePageState extends State<ExampleHomePage> {
  // Section 1: Dates & Themes
  static const _months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  static final _days = List.generate(31, (i) => '${i + 1}');

  String _month = 'Jan';
  String _day = '15';
  int _monthIndex = 0;
  int _dayIndex = 14;

  final _monthFocus = FocusNode();

  // Section 2: Time Picker & Programmatic Control
  static final _hours = List.generate(12, (i) => i + 1);
  static final _minutes = List.generate(60, (i) => i);
  static const _periods = ['AM', 'PM'];

  int _hour = 7;
  int _minute = 30;
  String _period = 'AM';

  late final _hourController = WheelController<int>(
    options: _hours,
    value: _hour,
    loop: true,
    onChanged: (v) => setState(() => _hour = v),
  );

  late final _minuteController = WheelController<int>(
    options: _minutes,
    value: _minute,
    loop: true,
    onChanged: (v) => setState(() => _minute = v),
  );

  late final _periodController = WheelController<String>(
    options: _periods,
    value: _period,
    onChanged: (v) => setState(() => _period = v),
  );

  // Section 3: Custom Item Builder, Disabled Items & Filled Overlay
  static const _fruits = [
    'Apple',
    'Banana',
    'Cat',
    'Cherry',
    'Dog',
    'Durian',
    'Grape',
    'Jackfruit',
    'Kiwi',
    'Mango',
  ];
  String _fruit = 'Apple';

  // Section 4: Pure Reactive (No setState)
  late final _reactiveController = WheelController<String>(
    options: const ['Low', 'Medium', 'High', 'Critical'],
    value: 'Medium',
  );

  // Section 5: Dynamic Options & Form
  static const _categories = {
    'Languages': ['Dart', 'Kotlin', 'Swift', 'TypeScript', 'Rust', 'Go'],
    'Databases': ['PostgreSQL', 'SQLite', 'Redis', 'MongoDB', 'Supabase'],
    'Cloud': ['Google Cloud', 'AWS', 'Azure', 'Cloudflare', 'Vercel'],
  };
  String _selectedCategory = 'Languages';
  String _selectedTech = 'Dart';
  final _formKey = GlobalKey<FormState>();

  // Section 6: Horizontal Orientation & Explicit Null Option
  static const _ratings = [null, 1, 2, 3, 4, 5];
  int? _rating;

  // Section 7: Styled Header with WheelHeader
  static const _currencies = [
    'USD',
    'EUR',
    'GBP',
    'JPY',
    'IDR',
    'SGD',
    'AUD',
    'CAD',
    'CHF',
  ];
  String _currency = 'USD';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _monthFocus.requestFocus();
    });
  }

  @override
  void dispose() {
    _monthFocus.dispose();
    _hourController.dispose();
    _minuteController.dispose();
    _periodController.dispose();
    _reactiveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // SECTION 1: Subtree Theming with WheelChoiceTheme
    final section1 = _Section(
      title: '1. Subtree Theming (WheelChoiceTheme)',
      subtitle: 'Shared itemExtent, overlays, and haptics across children',
      children: [
        WheelChoiceTheme(
          data: WheelChoiceThemeData(
            itemExtent: 44,
            itemVisible: 5,
            overlay: WheelOverlay.outlined(inset: 8),
            haptics: true,
            effect: const WheelEffect(useMagnifier: true, magnification: 1.08),
          ),
          child: Row(
            spacing: 12,
            children: [
              Expanded(
                child: WheelChoice<String>(
                  options: _months,
                  value: _month,
                  onChanged: (v) => setState(() => _month = v),
                  onIndexChanged: (i) => setState(() => _monthIndex = i),
                  header: const WheelHeader(child: Text('Month')),
                  focusNode: _monthFocus,
                  keyboard: true,
                  loop: true,
                ),
              ),
              Expanded(
                child: WheelChoice<String>(
                  options: _days,
                  value: _day,
                  onChanged: (v) => setState(() => _day = v),
                  onIndexChanged: (i) => setState(() => _dayIndex = i),
                  header: const WheelHeader(child: Text('Day')),
                  itemBuilder: WheelItem.delegate(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    selectedStyle: TextStyle(
                      fontSize: 16,
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Selected: $_month $_day (Month idx: $_monthIndex, Day idx: $_dayIndex)',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );

    // SECTION 2: Time Picker & Programmatic Navigation
    final section2 = _Section(
      title: '2. Time Picker & Stepper Navigation',
      subtitle:
          'Programmatic next(), previous(), animateToValue, and jumpToValue',
      children: [
        SizedBox(
          height: 220,
          child: Row(
            children: [
              Expanded(
                child: WheelChoice<int>.raw(
                  controller: _hourController,
                  itemLabel: (v) => v.toString().padLeft(2, '0'),
                  header: const WheelHeader(child: Text('Hour')),
                  overlay: WheelOverlay.outlined(inset: 2),
                  effect: const WheelEffect.flat(),
                  expanded: true,
                ),
              ),
              Expanded(
                child: WheelChoice<int>.raw(
                  controller: _minuteController,
                  itemLabel: (v) => v.toString().padLeft(2, '0'),
                  header: const WheelHeader(child: Text('Minute')),
                  overlay: WheelOverlay.outlined(inset: 2),
                  effect: const WheelEffect.flat(),
                  expanded: true,
                ),
              ),
              Expanded(
                child: WheelChoice<String>.raw(
                  controller: _periodController,
                  header: const WheelHeader(child: Text('AM/PM')),
                  overlay: WheelOverlay.outlined(inset: 2),
                  effect: const WheelEffect.flat(),
                  expanded: true,
                ),
              ),
            ],
          ),
        ),
        Text(
          'Selected: ${_hour.toString().padLeft(2, '0')}:${_minute.toString().padLeft(2, '0')} $_period',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            OutlinedButton.icon(
              onPressed: () => _hourController.previous(),
              icon: const Icon(Icons.arrow_upward, size: 16),
              label: const Text('Hour -1'),
            ),
            OutlinedButton.icon(
              onPressed: () => _hourController.next(),
              icon: const Icon(Icons.arrow_downward, size: 16),
              label: const Text('Hour +1'),
            ),
            OutlinedButton.icon(
              onPressed: () => _minuteController.previous(),
              icon: const Icon(Icons.arrow_upward, size: 16),
              label: const Text('Min -1'),
            ),
            OutlinedButton.icon(
              onPressed: () => _minuteController.next(),
              icon: const Icon(Icons.arrow_downward, size: 16),
              label: const Text('Min +1'),
            ),
            FilledButton.tonal(
              onPressed: () async {
                await Future.wait([
                  _hourController.animateToValue(12),
                  _minuteController.animateToValue(0),
                  _periodController.animateToValue('PM'),
                ]);
              },
              child: const Text('Animate 12:00 PM'),
            ),
          ],
        ),
      ],
    );

    // SECTION 3: Custom Builder, Disabled Items & Filled Overlay
    final section3 = _Section(
      title: '3. Custom Builder, Disabled Items & Filled Overlay',
      subtitle:
          'WheelOverlay.filled, icons, badges, and disabled item skipping',
      children: [
        SizedBox(
          height: 200,
          child: WheelChoice<String>(
            options: _fruits,
            value: _fruit,
            onChanged: (v) => setState(() => _fruit = v),
            itemDisabled: (v) => ['Cat', 'Dog', 'Durian'].contains(v),
            itemExtent: 44,
            overlay: WheelOverlay.filled(
              color: theme.colorScheme.primaryContainer.withValues(alpha: 0.4),
              cornerRadius: 10,
              inset: 8,
            ),
            itemBuilder: (context, item) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          item.disabled ? Icons.block : Icons.eco,
                          size: 18,
                          color: item.disabled
                              ? theme.disabledColor
                              : (item.selected
                                    ? theme.colorScheme.primary
                                    : theme.unselectedWidgetColor),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          item.label,
                          style: TextStyle(
                            color: item.disabled ? theme.disabledColor : null,
                            fontWeight: item.selected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    if (item.disabled)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.errorContainer,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Disabled',
                          style: TextStyle(
                            fontSize: 10,
                            color: theme.colorScheme.onErrorContainer,
                          ),
                        ),
                      )
                    else if (item.selected)
                      Icon(
                        Icons.check_circle,
                        size: 18,
                        color: theme.colorScheme.primary,
                      ),
                  ],
                ),
              );
            },
          ),
        ),
        Text(
          'Selected: $_fruit (Cat, Dog, Durian are disabled)',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );

    // SECTION 4: Pure Reactive Listeners (No Parent setState)
    final section4 = _Section(
      title: '4. Pure Reactive Listeners (No Parent Rebuild)',
      subtitle: 'Listening to valueListenable and indexListenable directly',
      children: [
        SizedBox(
          height: 160,
          child: WheelChoice<String>.raw(
            controller: _reactiveController,
            overlay: WheelOverlay.outlined(inset: 20),
            itemExtent: 40,
          ),
        ),
        ValueListenableBuilder<String?>(
          valueListenable: _reactiveController.valueListenable,
          builder: (context, val, _) {
            return ValueListenableBuilder<int>(
              valueListenable: _reactiveController.indexListenable,
              builder: (context, idx, _) {
                return Text(
                  'Reactive Output: ${val ?? '-'} (Index: $idx) - Parent never rebuilt!',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.tertiary,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            );
          },
        ),
      ],
    );

    // SECTION 5: Dynamic Options Updating & Form Validation
    final currentTechOptions = _categories[_selectedCategory] ?? [];
    final section5 = _Section(
      title: '5. Dynamic Options & Form Field Integration',
      subtitle: 'Options update dynamically when category changes',
      children: [
        SegmentedButton<String>(
          segments: _categories.keys
              .map((c) => ButtonSegment<String>(value: c, label: Text(c)))
              .toList(),
          selected: {_selectedCategory},
          onSelectionChanged: (set) {
            setState(() {
              _selectedCategory = set.first;
              _selectedTech = _categories[_selectedCategory]!.first;
            });
          },
        ),
        const SizedBox(height: 8),
        Form(
          key: _formKey,
          child: WheelChoiceFormField<String>(
            options: currentTechOptions,
            initialValue: _selectedTech,
            onChanged: (v) {
              if (v != null) {
                setState(() => _selectedTech = v);
              }
            },
            decoration: const InputDecoration(
              labelText: 'Technology',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(8),
            ),
            validator: (v) =>
                (v == null || v.isEmpty) ? 'Please pick an item' : null,
            overlay: WheelOverlay.outlined(inset: 16),
            itemVisible: 3,
            itemExtent: 40,
          ),
        ),
        Text(
          'Selected Tech: $_selectedCategory -> $_selectedTech',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );

    // SECTION 6: Horizontal Orientation & Explicit Null Option
    final section6 = _Section(
      title: '6. Horizontal Picker & Explicit Null Option',
      subtitle:
          'scrollDirection: Axis.horizontal with nullable options [null, 1..5]',
      children: [
        Center(
          child: SizedBox(
            height: 70,
            child: WheelChoice<int?>(
              options: _ratings,
              value: _rating,
              scrollDirection: Axis.horizontal,
              itemExtent: 80,
              itemVisible: 5,
              itemLabel: (v) => v == null ? 'None' : '★ $v',
              onChanged: (v) => setState(() => _rating = v),
              overlay: WheelOverlay.outlined(axis: Axis.horizontal, inset: 4),
            ),
          ),
        ),
        Text(
          'Selected Rating: ${_rating != null ? '★ $_rating' : 'None (null)'}',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );

    // SECTION 7: Styled Header with WheelHeader
    final section7 = _Section(
      title: '7. Rich Header Styling (WheelHeader)',
      subtitle:
          'extent, decoration, align, leading icons, and badge tags in WheelHeader',
      children: [
        Center(
          child: Container(
            width: 280,
            decoration: BoxDecoration(
              border: Border.all(color: theme.colorScheme.outlineVariant),
              borderRadius: BorderRadius.circular(12),
            ),
            clipBehavior: Clip.antiAlias,
            child: WheelChoice<String>(
              options: _currencies,
              value: _currency,
              onChanged: (v) => setState(() => _currency = v),
              itemExtent: 44,
              itemVisible: 5,
              header: WheelHeader(
                extent: 48,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer.withValues(
                    alpha: 0.5,
                  ),
                  border: Border(
                    bottom: BorderSide(color: theme.colorScheme.outlineVariant),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.currency_exchange,
                            size: 18,
                            color: theme.colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Currency',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onPrimaryContainer,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          _currency,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              overlay: WheelOverlay.filled(
                color: theme.colorScheme.primary.withValues(alpha: 0.08),
                cornerRadius: 8,
                inset: 8,
              ),
              itemBuilder: WheelItem.delegate(
                selectedStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
          ),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(title: const Text('wheel_choice showcases'), elevation: 1),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 16,
          children: [
            section1,
            section2,
            section3,
            section4,
            section5,
            section6,
            section7,
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({
    required this.title,
    required this.subtitle,
    required this.children,
  });

  final String title;
  final String subtitle;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0.5,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(subtitle),
              contentPadding: EdgeInsets.zero,
              minVerticalPadding: 0,
              minTileHeight: 0,
            ),
            const Divider(height: 1),
            Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: children,
            ),
          ],
        ),
      ),
    );
  }
}
