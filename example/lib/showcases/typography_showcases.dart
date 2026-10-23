import 'package:flutter/material.dart';
import 'package:widgetarian/widgetarian.dart';
import '../widgets/showcase_scaffold.dart';

class WxTextShowcase extends StatefulWidget {
  const WxTextShowcase({super.key});

  @override
  State<WxTextShowcase> createState() => _WxTextShowcaseState();
}

class _WxTextShowcaseState extends State<WxTextShowcase> {
  double _outlineWidth = 2.0;
  final Color _outlineColor = Colors.deepPurple;
  String _inputSearch = 'Flutter';

  @override
  Widget build(BuildContext context) {
    return ShowcaseScaffold(
      packageName: 'wx_text',
      version: '4.0.0',
      description:
          'Comprehensive declarative typography engine with outline strokes, gradient shaders, and high-performance pattern parsing.',
      children: [
        ShowcaseCard(
          title: 'Outlined & Stroke Typography',
          subtitle: 'Draw crisp vector outlines around text with adjustable stroke width and fill.',
          codeSnippet: '''
WxText.headlineMedium(
  'Outlined Typography',
  outlineColor: Colors.deepPurple,
  outlineWidth: $_outlineWidth,
  fontWeight: FontWeight.bold,
)''',
          child: Column(
            children: [
              WxText.headlineMedium(
                'Outlined Typography',
                outlineColor: _outlineColor,
                outlineWidth: _outlineWidth,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text('Width:'),
                  Expanded(
                    child: Slider(
                      value: _outlineWidth,
                      min: 0.5,
                      max: 6.0,
                      divisions: 11,
                      label: _outlineWidth.toStringAsFixed(1),
                      onChanged: (val) => setState(() => _outlineWidth = val),
                    ),
                  ),
                  Text('${_outlineWidth.toStringAsFixed(1)}px'),
                ],
              ),
            ],
          ),
        ),
        const ShowcaseCard(
          title: 'Gradient Shader Text',
          subtitle: 'Apply multi-stop linear and radial shader masks effortlessly to typography.',
          codeSnippet: '''
WxText.headlineMedium(
  'Vibrant Gradient Text',
  fontWeight: FontWeight.w900,
  gradient: LinearGradient(
    colors: [Colors.purple, Colors.pink, Colors.amber],
  ),
)''',
          child: Center(
            child: WxText.headlineMedium(
              'Vibrant Gradient Text',
              fontWeight: FontWeight.w900,
              gradient: LinearGradient(
                colors: [Colors.purple, Colors.pink, Colors.amber],
              ),
            ),
          ),
        ),
        ShowcaseCard(
          title: 'Parsed & Highlighted Pattern Text',
          subtitle: 'Matches URLs, @mentions, #hashtags, and real-time search queries with interactive click handlers.',
          codeSnippet: '''
ParsedText(
  'Explore #widgetarian at https://github.com/davigmacode for @flutter devs!',
  highlight: '$_inputSearch',
  highlightStyle: const TextStyle(backgroundColor: Colors.amberAccent),
  filter: [
    WxTextFilter.url(),
    WxTextFilter.hashtag(),
    WxTextFilter.mention(),
  ],
)''',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Highlight keyword',
                  prefixIcon: Icon(Icons.search),
                  isDense: true,
                  border: OutlineInputBorder(),
                ),
                onChanged: (val) => setState(() => _inputSearch = val),
              ),
              const SizedBox(height: 16),
              ParsedText(
                'Explore #widgetarian ecosystem at https://github.com/davigmacode/flutter_wx for @flutter developers with dynamic searching.',
                highlight: _inputSearch.isEmpty ? null : _inputSearch,
                highlightStyle: const TextStyle(
                  backgroundColor: Colors.amberAccent,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                filter: [
                  WxTextFilter.url(
                    style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                    onTap: (url) => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Clicked URL: $url')),
                    ),
                  ),
                  WxTextFilter.hashtag(
                    style: const TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold),
                    onTap: (tag) => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Clicked tag: $tag')),
                    ),
                  ),
                  WxTextFilter.mention(
                    style: const TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
                    onTap: (user) => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Clicked mention: $user')),
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

class WxTextAnimatedShowcase extends StatefulWidget {
  const WxTextAnimatedShowcase({super.key});

  @override
  State<WxTextAnimatedShowcase> createState() => _WxTextAnimatedShowcaseState();
}

class _WxTextAnimatedShowcaseState extends State<WxTextAnimatedShowcase> {
  int _transitionIndex = 0;

  final List<String> _names = ['shimmer', 'typing', 'fade', 'shake'];

  @override
  Widget build(BuildContext context) {
    return ShowcaseScaffold(
      packageName: 'wx_text_animated',
      version: '1.0.0',
      description:
          'Animated typography transitions: typewriter typing, shimmer gradient sweeps, fade, shake, and wave effects built on animated_repeatable.',
      children: [
        ShowcaseCard(
          title: 'Live Animation Playground',
          subtitle: 'Switch between animated transitions with customizable speeds and loops.',
          codeSnippet: '''
WxAnimatedText(
  duration: const Duration(seconds: 3),
  transition: ${_transitionIndex == 0 ? "WxAnimatedText.shimmer(colors: [Colors.purple, Colors.pink, Colors.amber])" : _transitionIndex == 1 ? "WxAnimatedText.typing()" : _transitionIndex == 2 ? "WxAnimatedText.fade" : "WxAnimatedText.shake()"},
  child: const Text('Building next-generation Flutter UI with Widgetarian!'),
)''',
          child: Column(
            children: [
              Wrap(
                spacing: 8,
                children: List.generate(_names.length, (i) {
                  return ChoiceChip(
                    label: Text(_names[i]),
                    selected: _transitionIndex == i,
                    onSelected: (sel) {
                      if (sel) setState(() => _transitionIndex = i);
                    },
                  );
                }),
              ),
              const SizedBox(height: 32),
              Container(
                height: 100,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest.withAlpha(60),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: KeyedSubtree(
                  key: ValueKey(_transitionIndex),
                  child: WxAnimatedText(
                    duration: const Duration(seconds: 3),
                    transition: _transitionIndex == 0
                        ? WxAnimatedText.shimmer(colors: const [Colors.purple, Colors.pink, Colors.amber])
                        : _transitionIndex == 1
                            ? WxAnimatedText.typing()
                            : _transitionIndex == 2
                                ? WxAnimatedText.fade
                                : WxAnimatedText.shake(),
                    child: const Text(
                      'Building next-generation Flutter UI with Widgetarian!',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class WxSpoilerShowcase extends StatelessWidget {
  const WxSpoilerShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return ShowcaseScaffold(
      packageName: 'wx_spoiler',
      version: '1.0.0',
      description:
          'Interactive privacy concealment and expandable spoilers. Supports widget and image blur conceal as well as collapsible inline text spoilers.',
      children: [
        ShowcaseCard(
          title: 'Widget & Image Spoiler (Tap to Reveal)',
          subtitle: 'Applies an interactive backdrop blur overlay with custom placeholder label or icon.',
          codeSnippet: '''
WxSpoiler(
  overlay: Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(24)),
    child: const Row(children: [Icon(Icons.visibility_off), Text('Sensitive Content • Tap to reveal')]),
  ),
  child: Container(...),
)''',
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: WxSpoiler(
                overlay: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(180),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.visibility_off_rounded, size: 18, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Confidential • Tap to reveal',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                child: Container(
                  width: 320,
                  height: 180,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.indigo, Colors.purple, Colors.deepOrange],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.lock_open_rounded, size: 48, color: Colors.white),
                      SizedBox(height: 12),
                      Text(
                        'Confidential Financial Report\n\$1,450,000.00 Net Revenue',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        const ShowcaseCard(
          title: 'Collapsible Text Spoiler',
          subtitle: 'Tap to toggle visibility and expand concealed text.',
          codeSnippet: '''
WxSpoilerText(
  'Flutter is Google\\'s UI toolkit for crafting beautiful applications...',
)''',
          child: WxSpoilerText(
            'Flutter is Google\'s UI toolkit for crafting beautiful, natively compiled applications for mobile, web, and desktop from a single codebase. Widgetarian amplifies this productivity by offering a unified design ecosystem with micro-animations, headless pickers, advanced dividers, and full cross-platform ergonomics.',
          ),
        ),
      ],
    );
  }
}
