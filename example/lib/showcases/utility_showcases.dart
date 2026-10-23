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
                        fontFamily: 'monospace',
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
  final ThemeMode themeMode;
  final Color seedColor;
  final ValueChanged<ThemeMode> onThemeModeChanged;
  final ValueChanged<Color> onSeedColorChanged;

  const ThemePatrolShowcase({
    super.key,
    required this.themeMode,
    required this.seedColor,
    required this.onThemeModeChanged,
    required this.onSeedColorChanged,
  });

  static const List<Color> _palette = [
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.teal,
    Colors.green,
    Colors.amber,
    Colors.deepOrange,
    Colors.pink,
  ];

  @override
  Widget build(BuildContext context) {
    return ShowcaseScaffold(
      packageName: 'theme_patrol',
      version: '3.2.3',
      description:
          'Effortless multi-theme manager supporting Material 3 color schemes, dark/light/system theme modes, and persistence.',
      children: [
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
            selected: {themeMode},
            onSelectionChanged: (val) => onThemeModeChanged(val.first),
          ),
        ),
        ShowcaseCard(
          title: 'Dynamic Seed Color Palette',
          subtitle: 'Select any color to regenerate the M3 ColorScheme dynamically.',
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: _palette.map((color) {
              final isSelected = seedColor.toARGB32() == color.toARGB32();
              return GestureDetector(
                onTap: () => onSeedColorChanged(color),
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
