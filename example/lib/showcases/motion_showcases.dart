import 'package:flutter/material.dart';
import 'package:widgetarian/widgetarian.dart';
import '../widgets/showcase_scaffold.dart';

class AnimatedCheckmarkShowcase extends StatefulWidget {
  const AnimatedCheckmarkShowcase({super.key});

  @override
  State<AnimatedCheckmarkShowcase> createState() => _AnimatedCheckmarkShowcaseState();
}

class _AnimatedCheckmarkShowcaseState extends State<AnimatedCheckmarkShowcase> {
  bool _checked = true;
  double _strokeWidth = 6.0;

  @override
  Widget build(BuildContext context) {
    return ShowcaseScaffold(
      packageName: 'animated_checkmark',
      version: '3.1.0',
      description:
          'Vector checkmark drawing animation with configurable strokes, radiuses, colors, and success/cross transitions.',
      children: [
        ShowcaseCard(
          title: 'Interactive Animated Stroke',
          subtitle: 'Tap to trigger the stroke vector animation.',
          codeSnippet: '''
Checkmark(
  checked: $_checked,
  color: Colors.green,
  size: 80,
  weight: $_strokeWidth,
)''',
          child: Column(
            children: [
              GestureDetector(
                onTap: () => setState(() => _checked = !_checked),
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: (_checked ? Colors.green : Colors.red).withAlpha(30),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Checkmark(
                    checked: _checked,
                    color: _checked ? Colors.green : Colors.red,
                    size: 80,
                    weight: _strokeWidth,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                _checked ? 'Status: Success (Tap to Toggle)' : 'Status: Incomplete',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text('Stroke Weight:'),
                  Expanded(
                    child: Slider(
                      value: _strokeWidth,
                      min: 2.0,
                      max: 12.0,
                      onChanged: (val) => setState(() => _strokeWidth = val),
                    ),
                  ),
                  Text('${_strokeWidth.round()}px'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AnimatedRepeatableShowcase extends StatefulWidget {
  const AnimatedRepeatableShowcase({super.key});

  @override
  State<AnimatedRepeatableShowcase> createState() => _AnimatedRepeatableShowcaseState();
}

class _AnimatedRepeatableShowcaseState extends State<AnimatedRepeatableShowcase> {
  int _effectIndex = 0;
  final List<String> _effects = ['fade', 'spin', 'zoom', 'shake', 'shimmer'];

  @override
  Widget build(BuildContext context) {
    return ShowcaseScaffold(
      packageName: 'animated_repeatable',
      version: '1.2.0',
      description:
          'Declarative looping and periodic micro-interactions: pulse, wobble, shake, rotate, and bounce with zero boilerplate.',
      children: [
        ShowcaseCard(
          title: 'Effect Selector',
          subtitle: 'Choose between various declarative looping curves.',
          codeSnippet: '''
AnimatedRepeatable(
  duration: const Duration(milliseconds: 1200),
  transition: ${_effectIndex == 0 ? "AnimatedRepeatable.fade" : _effectIndex == 1 ? "AnimatedRepeatable.spin" : _effectIndex == 2 ? "AnimatedRepeatable.zoom()" : _effectIndex == 3 ? "AnimatedRepeatable.shake()" : "AnimatedRepeatable.shimmer(colors: [Colors.purple, Colors.pink, Colors.amber])"},
  child: Icon(Icons.flash_on, size: 48),
)''',
          child: Column(
            children: [
              Wrap(
                spacing: 8,
                children: List.generate(_effects.length, (i) {
                  return ChoiceChip(
                    label: Text(_effects[i]),
                    selected: _effectIndex == i,
                    onSelected: (sel) {
                      if (sel) setState(() => _effectIndex = i);
                    },
                  );
                }),
              ),
              const SizedBox(height: 40),
              Center(
                child: KeyedSubtree(
                  key: ValueKey(_effectIndex),
                  child: AnimatedRepeatable(
                    duration: const Duration(milliseconds: 1200),
                    transition: _effectIndex == 0
                        ? AnimatedRepeatable.fade
                        : _effectIndex == 1
                            ? AnimatedRepeatable.spin
                            : _effectIndex == 2
                                ? AnimatedRepeatable.zoom()
                                : _effectIndex == 3
                                    ? AnimatedRepeatable.shake()
                                    : AnimatedRepeatable.shimmer(
                                        colors: const [Colors.purple, Colors.pink, Colors.amber],
                                      ),
                    child: Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.deepPurple.withAlpha(100),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: const Icon(Icons.flash_on_rounded, color: Colors.white, size: 48),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }
}

class AnimatedSwitcherShowcase extends StatefulWidget {
  const AnimatedSwitcherShowcase({super.key});

  @override
  State<AnimatedSwitcherShowcase> createState() => _AnimatedSwitcherShowcaseState();
}

class _AnimatedSwitcherShowcaseState extends State<AnimatedSwitcherShowcase> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return ShowcaseScaffold(
      packageName: 'animated_switcher_transitions',
      version: '1.0.0',
      description:
          'Collection of 15+ ready-to-use transition builders for AnimatedSwitcher: zoom, flipX, flipY, slide, and rotate.',
      children: [
        ShowcaseCard(
          title: 'Flip and Zoom Transitions',
          subtitle: 'Tap Next to cycle through widgets with 3D Flip transition.',
          codeSnippet: '''
AnimatedSwitcher(
  duration: const Duration(milliseconds: 500),
  transitionBuilder: AnimatedSwitcherTransitions.flipY,
  child: Container(key: ValueKey(_counter), ...),
)''',
          child: Column(
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: AnimatedSwitcherTransitions.flipY,
                child: Container(
                  key: ValueKey(_counter),
                  width: 140,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.primaries[_counter % Colors.primaries.length],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Card #$_counter',
                    style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: () => setState(() => _counter++),
                icon: const Icon(Icons.swap_horiz_rounded),
                label: const Text('Next Item'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AnimatedTransformShowcase extends StatefulWidget {
  const AnimatedTransformShowcase({super.key});

  @override
  State<AnimatedTransformShowcase> createState() => _AnimatedTransformShowcaseState();
}

class _AnimatedTransformShowcaseState extends State<AnimatedTransformShowcase> {
  double _scale = 1.0;
  double _rotate = 0.0;

  @override
  Widget build(BuildContext context) {
    return ShowcaseScaffold(
      packageName: 'animated_transform',
      version: '1.0.6',
      description:
          'Implicitly animated equivalent to Transform. Animates scale, rotation, translation, and matrix transitions automatically.',
      children: [
        ShowcaseCard(
          title: 'Interactive Scale & Rotation',
          subtitle: 'Slide controls to see smooth implicit matrix transformations.',
          codeSnippet: '''
AnimatedTransform(
  duration: const Duration(milliseconds: 300),
  scale: $_scale,
  rotate: $_rotate,
  child: ...,
)''',
          child: Column(
            children: [
              const SizedBox(height: 20),
              AnimatedTransform(
                duration: const Duration(milliseconds: 300),
                scale: _scale,
                rotate: _rotate,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(Icons.star_rounded, size: 50, color: Colors.white),
                ),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  const Text('Scale:'),
                  Expanded(
                    child: Slider(
                      value: _scale,
                      min: 0.5,
                      max: 1.8,
                      onChanged: (val) => setState(() => _scale = val),
                    ),
                  ),
                  Text(_scale.toStringAsFixed(2)),
                ],
              ),
              Row(
                children: [
                  const Text('Rotate:'),
                  Expanded(
                    child: Slider(
                      value: _rotate,
                      min: 0.0,
                      max: 3.14 * 2,
                      onChanged: (val) => setState(() => _rotate = val),
                    ),
                  ),
                  Text('${(_rotate * 180 / 3.14).round()}°'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AnimatedIconThemeShowcase extends StatefulWidget {
  const AnimatedIconThemeShowcase({super.key});

  @override
  State<AnimatedIconThemeShowcase> createState() => _AnimatedIconThemeShowcaseState();
}

class _AnimatedIconThemeShowcaseState extends State<AnimatedIconThemeShowcase> {
  bool _active = false;

  @override
  Widget build(BuildContext context) {
    return ShowcaseScaffold(
      packageName: 'animated_icon_theme',
      version: '1.0.4',
      description:
          'Implicit animated widget for IconThemeData, enabling smooth color, size, and opacity interpolation on icons.',
      children: [
        ShowcaseCard(
          title: 'Smooth Icon Theme Morph',
          subtitle: 'Toggle state to watch size, opacity, and color interpolate smoothly.',
          codeSnippet: '''
AnimatedIconTheme(
  duration: const Duration(milliseconds: 350),
  data: IconThemeData(
    color: ${_active ? "Colors.deepOrange" : "Colors.grey"},
    size: ${_active ? 56 : 32},
    opacity: ${_active ? 1.0 : 0.4},
  ),
  child: Row(children: [...]),
)''',
          child: Column(
            children: [
              AnimatedIconTheme(
                duration: const Duration(milliseconds: 350),
                data: IconThemeData(
                  color: _active ? Colors.deepOrange : Colors.grey,
                  size: _active ? 56 : 32,
                  opacity: _active ? 1.0 : 0.4,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.favorite_rounded),
                    Icon(Icons.bookmark_rounded),
                    Icon(Icons.share_rounded),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => setState(() => _active = !_active),
                child: Text(_active ? 'Deactivate' : 'Activate Theme'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MarqueeTransitionShowcase extends StatelessWidget {
  const MarqueeTransitionShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return const ShowcaseScaffold(
      packageName: 'marquee_transition',
      version: '0.1.0',
      description:
          'Continuous scrolling marquee ticker with configurable velocity, direction, pause on hover, and smooth looping.',
      children: [
        ShowcaseCard(
          title: 'Horizontal Marquee Ticker',
          subtitle: 'Auto-scrolls overflow text with continuous loop animation.',
          codeSnippet: '''
MarqueeTransition(
  duration: Duration(seconds: 8),
  children: [
    Text('🚀 Widgetarian Monorepo is now live!'),
  ],
)''',
          child: Center(
            child: SizedBox(
              width: 320,
              child: MarqueeTransition(
                duration: Duration(seconds: 8),
                children: [
                  Text(
                    '🔥 Breaking: Widgetarian Showroom v1.0.0 is officially released! Enjoy 25 high-performance modular Flutter UI packages! • ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
