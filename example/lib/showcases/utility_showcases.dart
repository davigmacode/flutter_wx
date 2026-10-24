import 'package:flutter/material.dart';
import 'package:widgetarian/widgetarian.dart';
import '../widgets/showcase_scaffold.dart';

class GachaShowcase extends StatefulWidget {
  const GachaShowcase({super.key});

  @override
  State<GachaShowcase> createState() => _GachaShowcaseState();
}

class _GachaShowcaseState extends State<GachaShowcase> {
  late Gacha _gacha;
  String _email = '';
  String _phone = '';
  int _number = 0;
  String _words = '';
  String _paragraph = '';

  @override
  void initState() {
    super.initState();
    _gacha = Gacha.instance;
    _roll();
  }

  void _roll() {
    setState(() {
      _email = _gacha.email();
      _phone = _gacha.phone();
      _number = _gacha.integer(min: 100, max: 9999);
      _words = _gacha.words(4);
      _paragraph = _gacha.paragraphs(1, wordsMin: 15, wordsMax: 20);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ShowcaseScaffold(
      packageName: 'gacha',
      version: '1.0.0',
      description:
          'Lightweight mock data generation library with deterministic seed support. Generates random emails, phone numbers, numbers, words, and text schemas.',
      children: [
        ShowcaseCard(
          title: 'Interactive Random Data Generator',
          subtitle: 'Roll for newly generated realistic mock values.',
          codeSnippet: '''
final gacha = Gacha.instance;
final email = gacha.email();
final phone = gacha.phone();
final number = gacha.integer(min: 100, max: 9999);
final words = gacha.words(4);''',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: const Icon(Icons.email_outlined),
                title: const Text('Email'),
                subtitle: Text(_email, style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
              ListTile(
                leading: const Icon(Icons.phone_outlined),
                title: const Text('Phone'),
                subtitle: Text(_phone, style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
              ListTile(
                leading: const Icon(Icons.numbers_outlined),
                title: const Text('Random Integer (100 - 9999)'),
                subtitle: Text('$_number', style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
              ListTile(
                leading: const Icon(Icons.abc_outlined),
                title: const Text('Words'),
                subtitle: Text(_words, style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
              ListTile(
                leading: const Icon(Icons.article_outlined),
                title: const Text('Generated Paragraph'),
                subtitle: Text(_paragraph),
              ),
              const SizedBox(height: 16),
              Center(
                child: FilledButton.icon(
                  onPressed: _roll,
                  icon: const Icon(Icons.casino_rounded),
                  label: const Text('Roll Gacha'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ChronographShowcase extends StatefulWidget {
  const ChronographShowcase({super.key});

  @override
  State<ChronographShowcase> createState() => _ChronographShowcaseState();
}

class _ChronographShowcaseState extends State<ChronographShowcase> {
  late final ChronoGraph _graph;

  @override
  void initState() {
    super.initState();
    _graph = ChronoGraph.stopwatch(autostart: false);
  }

  @override
  void dispose() {
    _graph.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShowcaseScaffold(
      packageName: 'chronograph',
      version: '1.0.2',
      description:
          'High-precision stopwatch and countdown timer engine powered by ValueListenable with ChronoView widget rendering.',
      children: [
        ShowcaseCard(
          title: 'Interactive Stopwatch',
          subtitle: 'Precise timer controls with millisecond accuracy.',
          codeSnippet: '''
ChronoView(
  graph: _graph,
  builder: (context, chrono, child) {
    return Text('\${chrono.minutes}:\${chrono.seconds}');
  },
)''',
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ChronoView(
                  graph: _graph,
                  builder: (context, chrono, child) {
                    final hours = chrono.hours.toString().padLeft(2, '0');
                    final minutes = chrono.minutes.toString().padLeft(2, '0');
                    final seconds = chrono.seconds.toString().padLeft(2, '0');
                    return Text(
                      '$hours:$minutes:$seconds',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Consolas',
                        fontFamilyFallback: const [
                          'Menlo',
                          'Monaco',
                          'Courier New',
                          'monospace',
                        ],
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilledButton.icon(
                    onPressed: () => _graph.start(),
                    icon: const Icon(Icons.play_arrow_rounded),
                    label: const Text('Start'),
                  ),
                  const SizedBox(width: 12),
                  FilledButton.tonalIcon(
                    onPressed: () => _graph.pause(),
                    icon: const Icon(Icons.pause_rounded),
                    label: const Text('Pause'),
                  ),
                  const SizedBox(width: 12),
                  OutlinedButton.icon(
                    onPressed: () => _graph.reset(),
                    icon: const Icon(Icons.replay_rounded),
                    label: const Text('Reset'),
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

class ThemePatrolShowcase extends StatelessWidget {
  const ThemePatrolShowcase({super.key});

  static const List<Color> _palette = [
    Colors.deepPurple,
    Colors.indigo,
    Colors.teal,
    Colors.green,
    Colors.deepOrange,
    Colors.pink,
    Colors.cyan,
    Colors.amber,
  ];

  @override
  Widget build(BuildContext context) {
    final themeController = ThemeProvider.of(context);
    final currentColor = themeController.color ?? Colors.deepPurple;

    return ShowcaseScaffold(
      packageName: 'theme_patrol',
      version: '3.2.3',
      description:
          'Effortless multi-theme manager supporting design system presets (M3/M2/iOS), color palettes, and theme modes.',
      children: [
        ShowcaseCard(
          title: 'Design System Preset',
          subtitle: 'Switch between Material 3, Material 2, and iOS Cupertino theme configurations.',
          child: SegmentedButton<String>(
            segments: const [
              ButtonSegment(
                value: 'm3',
                label: Text('Material 3'),
                icon: Icon(Icons.auto_awesome_rounded),
              ),
              ButtonSegment(
                value: 'm2',
                label: Text('Material 2'),
                icon: Icon(Icons.layers_rounded),
              ),
              ButtonSegment(
                value: 'ios',
                label: Text('iOS Cupertino'),
                icon: Icon(Icons.phone_iphone_rounded),
              ),
            ],
            selected: {themeController.selected},
            onSelectionChanged: (val) => themeController.select(val.first),
          ),
        ),
        ShowcaseCard(
          title: 'Theme Mode Switcher',
          subtitle: 'Toggle live theme mode across the entire showroom application.',
          child: SegmentedButton<ThemeMode>(
            segments: const [
              ButtonSegment(
                value: ThemeMode.light,
                label: Text('Light'),
                icon: Icon(Icons.light_mode_rounded),
              ),
              ButtonSegment(
                value: ThemeMode.dark,
                label: Text('Dark'),
                icon: Icon(Icons.dark_mode_rounded),
              ),
              ButtonSegment(
                value: ThemeMode.system,
                label: Text('System'),
                icon: Icon(Icons.settings_suggest_rounded),
              ),
            ],
            selected: {themeController.mode},
            onSelectionChanged: (val) => themeController.toMode(val.first),
          ),
        ),
        ShowcaseCard(
          title: 'Dynamic Seed Color Palette',
          subtitle: 'Select any color to regenerate the ColorScheme dynamically.',
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: _palette.map((color) {
              final isSelected = currentColor.toARGB32() == color.toARGB32();
              return GestureDetector(
                onTap: () => themeController.toColor(color),
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? Colors.white : Colors.transparent,
                      width: 3,
                    ),
                    boxShadow: [
                      if (isSelected)
                        BoxShadow(
                          color: color.withAlpha(120),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                    ],
                  ),
                  child: isSelected ? const Icon(Icons.check, color: Colors.white, size: 24) : null,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class WxUtilsShowcase extends StatelessWidget {
  const WxUtilsShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return ShowcaseScaffold(
      packageName: 'wx_utils',
      version: '0.0.5',
      description:
          'Core shared utilities for color blending, lightness manipulation, contrast calculation, and geometry helpers.',
      children: [
        ShowcaseCard(
          title: 'Color Manipulation Helpers',
          subtitle: 'Calculate contrasting surface text and transparency with ease.',
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildColorBox('Base Color', Colors.amber, Colors.black),
                _buildColorBox(
                  'On Surface',
                  Colors.indigo,
                  WxColors.onSurface(Colors.indigo) ?? Colors.white,
                ),
                _buildColorBox(
                  'Transparency',
                  WxColors.withTransparency(Colors.purple, opacity: 0.5) ?? Colors.purple,
                  Colors.white,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildColorBox(String label, Color bg, Color textColor) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.black12),
          ),
          alignment: Alignment.center,
          child: Text('Sample', style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
      ],
    );
  }
}

class LerpShowcase extends StatefulWidget {
  const LerpShowcase({super.key});

  @override
  State<LerpShowcase> createState() => _LerpShowcaseState();
}

class _LerpShowcaseState extends State<LerpShowcase> {
  double _t = 0.5;

  @override
  Widget build(BuildContext context) {
    final interpolatedColor = Color.lerp(Colors.blue, Colors.red, _t)!;
    final interpolatedInt = lerpInt(10, 100, _t);

    return ShowcaseScaffold(
      packageName: 'lerp',
      version: '0.0.2',
      description:
          'Micro-utility providing generic interpolation functions: lerpInt, lerpBool, and lerpEnum with zero overhead.',
      children: [
        ShowcaseCard(
          title: 'Visual Interpolation Slider',
          subtitle: 'Slide t between 0.0 and 1.0 to interpolate integer and color values.',
          child: Column(
            children: [
              Container(
                width: 140,
                height: 80,
                decoration: BoxDecoration(
                  color: interpolatedColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Value: $interpolatedInt',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  const Text('t factor:'),
                  Expanded(
                    child: Slider(
                      value: _t,
                      min: 0.0,
                      max: 1.0,
                      onChanged: (val) => setState(() => _t = val),
                    ),
                  ),
                  Text(_t.toStringAsFixed(2)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class WidgetEventShowcase extends StatefulWidget {
  const WidgetEventShowcase({super.key});

  @override
  State<WidgetEventShowcase> createState() => _WidgetEventShowcaseState();
}

class _WidgetEventShowcaseState extends State<WidgetEventShowcase> {
  final WidgetEventController _controller = WidgetEventController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final activeEvents = _controller.value;

    final resolvedColor = DrivenProperty.by<Color>((events) {
      if (WidgetEvent.isDisabled(events)) return Colors.grey;
      if (WidgetEvent.isErrored(events)) return Colors.red;
      if (WidgetEvent.isLoading(events)) return Colors.deepOrange;
      if (WidgetEvent.isPressed(events)) return Colors.amber;
      if (WidgetEvent.isHovered(events)) return Colors.cyan;
      if (WidgetEvent.isSelected(events)) return Colors.teal;
      return Colors.blue;
    }).resolve(activeEvents);

    return ShowcaseScaffold(
      packageName: 'widget_event',
      version: '2.0.1',
      description:
          'Extensible event-driven state orchestration for Flutter widgets. Super-set of WidgetState with built-in loading, indeterminate, error, and driven property resolvers.',
      children: [
        ShowcaseCard(
          title: 'Event State Controller & Driven Resolver',
          subtitle: 'Toggle active states to see real-time driven evaluation.',
          codeSnippet: '''
final controller = WidgetEventController();

// Driven property resolver
final color = DrivenProperty.by<Color>((events) {
  if (WidgetEvent.isLoading(events)) return Colors.deepOrange;
  if (WidgetEvent.isPressed(events)) return Colors.amber;
  return Colors.blue;
}).resolve(controller.value);''',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _eventChip(WidgetEvent.hovered, 'Hovered'),
                  _eventChip(WidgetEvent.focused, 'Focused'),
                  _eventChip(WidgetEvent.pressed, 'Pressed'),
                  _eventChip(WidgetEvent.selected, 'Selected'),
                  _eventChip(WidgetEvent.disabled, 'Disabled'),
                  _eventChip(WidgetEvent.error, 'Error'),
                  _eventChip(WidgetEvent.loading, 'Loading'),
                  _eventChip(const WidgetEvent('custom'), 'Custom: "custom"'),
                ],
              ),
              const SizedBox(height: 20),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: resolvedColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Builder(
                      builder: (context) {
                        final spinner = const DrivenSpinner(size: 28, color: Colors.white).resolve(activeEvents);
                        return spinner ?? const Icon(Icons.touch_app_rounded, color: Colors.white, size: 28);
                      },
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Active Events: [${activeEvents.map((e) => e.value).join(', ')}]',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _eventChip(WidgetEvent event, String label) {
    final isActive = _controller.value.contains(event);
    return FilterChip(
      label: Text(label),
      selected: isActive,
      onSelected: (_) => _controller.toggle(event),
    );
  }
}

class WidgetDrivenShowcase extends StatefulWidget {
  const WidgetDrivenShowcase({super.key});

  @override
  State<WidgetDrivenShowcase> createState() => _WidgetDrivenShowcaseState();
}

class _WidgetDrivenShowcaseState extends State<WidgetDrivenShowcase> {
  late final WidgetEventController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WidgetEventController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ShowcaseScaffold(
      packageName: 'widget_driven',
      version: '1.0.0',
      description:
          'Reactive event-driven widgets, builders, spinners, and animated transitions that adapt dynamically to active WidgetEvents.',
      children: [
        ShowcaseCard(
          title: 'DrivenBuilder',
          subtitle: 'Clean reactive builder reading events directly from WidgetEventController.',
          codeSnippet: '''
DrivenBuilder(
  controller: _controller,
  builder: (context, events, child) {
    final isLoading = events.contains(WidgetEvent.loading);
    return ElevatedButton.icon(
      onPressed: () => _controller.toggle(WidgetEvent.loading),
      icon: isLoading ? const DrivenSpinner(size: 16) : const Icon(Icons.send_rounded),
      label: Text(isLoading ? 'Processing...' : 'Send Request'),
    );
  },
)''',
          child: Column(
            children: [
              DrivenBuilder(
                controller: _controller,
                builder: (context, events, child) {
                  final isLoading = events.contains(WidgetEvent.loading);
                  final isDisabled = events.contains(WidgetEvent.disabled);
                  final isError = events.contains(WidgetEvent.error);

                  Color cardColor = colorScheme.surfaceContainerHighest;
                  if (isLoading) cardColor = colorScheme.primaryContainer;
                  if (isError) cardColor = colorScheme.errorContainer;

                  return Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: colorScheme.outlineVariant.withValues(alpha: 0.5)),
                    ),
                    child: Row(
                      children: [
                        if (isLoading)
                          const DrivenSpinner(size: 28, width: 3)
                        else if (isError)
                          Icon(Icons.error_outline_rounded, color: colorScheme.error, size: 28)
                        else
                          Icon(
                            isDisabled ? Icons.lock_outline_rounded : Icons.check_circle_outline_rounded,
                            color: colorScheme.primary,
                            size: 28,
                          ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isLoading
                                    ? 'State: Processing Action...'
                                    : isError
                                        ? 'State: Error Occurred'
                                        : isDisabled
                                            ? 'State: Component Disabled'
                                            : 'State: Ready & Interactive',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Active Events: ${events.isEmpty ? "{none}" : events.map((e) => e.value).toSet()}',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  FilterChip(
                    label: const Text('Toggle Loading'),
                    selected: _controller.value.contains(WidgetEvent.loading),
                    onSelected: (_) => _controller.toggle(WidgetEvent.loading),
                  ),
                  FilterChip(
                    label: const Text('Toggle Disabled'),
                    selected: _controller.value.contains(WidgetEvent.disabled),
                    onSelected: (_) => _controller.toggle(WidgetEvent.disabled),
                  ),
                  FilterChip(
                    label: const Text('Toggle Error'),
                    selected: _controller.value.contains(WidgetEvent.error),
                    onSelected: (_) => _controller.toggle(WidgetEvent.error),
                  ),
                ],
              ),
            ],
          ),
        ),
        ShowcaseCard(
          title: 'DrivenSwitcher & Animated Transitions',
          subtitle: 'AnimatedSwitcher that automatically morphs between child widgets as events change.',
          codeSnippet: '''
DrivenSwitcher(
  const Text('Submit Order'),
  atLoading: const DrivenSpinner(size: 20),
  atError: const Text('Retry'),
)''',
          child: Center(
            child: DrivenBuilder(
              controller: _controller,
              builder: (context, events, _) {
                return Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  alignment: Alignment.center,
                  child: DefaultTextStyle(
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    child: const DrivenSwitcher(
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.shopping_cart_checkout_rounded, color: Colors.white, size: 20),
                          SizedBox(width: 8),
                          Text('Place Order'),
                        ],
                      ),
                      atLoading: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          DrivenSpinner(size: 18, width: 2.5, color: Colors.white),
                          SizedBox(width: 8),
                          Text('Authorizing Payment...'),
                        ],
                      ),
                      atError: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.replay_rounded, color: Colors.white, size: 20),
                          SizedBox(width: 8),
                          Text('Retry Payment'),
                        ],
                      ),
                    ).resolve(events),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
