import 'package:flutter/material.dart';
import 'package:widgetarian/widgetarian.dart';
import '../widgets/showcase_scaffold.dart';

class WxBoxShowcase extends StatefulWidget {
  const WxBoxShowcase({super.key});

  @override
  State<WxBoxShowcase> createState() => _WxBoxShowcaseState();
}

class _WxBoxShowcaseState extends State<WxBoxShowcase> {
  bool _elevated = false;
  double _radius = 16.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ShowcaseScaffold(
      packageName: 'wx_box',
      version: '4.2.1',
      description:
          'Unified declarative box container integrating borders, linear/stadium shapes, elevation shadows, gradients, and implicit animations.',
      children: [
        ShowcaseCard(
          title: 'Interactive Animated Box',
          subtitle: 'Smoothly morph size, radius, colors, and shadows upon interaction.',
          codeSnippet: '''
WxAnimatedBox(
  duration: const Duration(milliseconds: 300),
  width: ${_elevated ? 260 : 200},
  height: 120,
  borderRadius: BorderRadius.circular($_radius),
  color: ${_elevated ? 'colorScheme.primary' : 'colorScheme.secondaryContainer'},
  elevation: ${_elevated ? 8 : 1},
  child: ...
)''',
          child: Column(
            children: [
              GestureDetector(
                onTap: () => setState(() => _elevated = !_elevated),
                child: WxAnimatedBox(
                  duration: const Duration(milliseconds: 300),
                  width: _elevated ? 260 : 200,
                  height: 120,
                  borderRadius: BorderRadius.circular(_radius),
                  color: _elevated ? colorScheme.primary : colorScheme.secondaryContainer,
                  elevation: _elevated ? 8 : 1,
                  alignment: Alignment.center,
                  child: Text(
                    _elevated ? 'Elevated (Tap to Shrink)' : 'Tap Me to Elevate',
                    style: TextStyle(
                      color: _elevated ? colorScheme.onPrimary : colorScheme.onSecondaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text('Corner Radius:'),
                  Expanded(
                    child: Slider(
                      value: _radius,
                      min: 0,
                      max: 48,
                      onChanged: (val) => setState(() => _radius = val),
                    ),
                  ),
                  Text('${_radius.round()}px'),
                ],
              ),
            ],
          ),
        ),
        ShowcaseCard(
          title: 'Stadium & Linear Border Shapes',
          subtitle: 'Decorate surfaces with individual border sides and stadium silhouettes.',
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              WxBox(
                width: 140,
                height: 50,
                borderRadius: BorderRadius.circular(25),
                color: colorScheme.surfaceContainerHighest,
                border: Border.all(color: colorScheme.primary, width: 2),
                alignment: Alignment.center,
                child: const Text('Stadium Box'),
              ),
              WxBox(
                width: 140,
                height: 50,
                color: colorScheme.surfaceContainerHighest,
                border: Border(
                  bottom: BorderSide(color: colorScheme.error, width: 4),
                  left: BorderSide(color: colorScheme.primary, width: 4),
                ),
                alignment: Alignment.center,
                child: const Text('Multi-Sided Border'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class WxDividerShowcase extends StatefulWidget {
  const WxDividerShowcase({super.key});

  @override
  State<WxDividerShowcase> createState() => _WxDividerShowcaseState();
}

class _WxDividerShowcaseState extends State<WxDividerShowcase> {
  double _thickness = 2.0;

  @override
  Widget build(BuildContext context) {
    return ShowcaseScaffold(
      packageName: 'wx_divider',
      version: '1.0.0',
      description:
          'Advanced dividers with solid, dashed, dotted, and Morse code patterns, multi-line offsets, gradient shaders, and embedded chips.',
      children: [
        ShowcaseCard(
          title: 'Line Patterns & Thickness',
          subtitle: 'Choose between dashed, dotted, Morse, or solid line patterns.',
          codeSnippet: '''
WxDivider(pattern: WxDivider.dashed, thickness: $_thickness, color: Colors.indigo)
WxDivider(pattern: WxDivider.dotted, thickness: $_thickness, color: Colors.teal)
WxDivider(pattern: WxDivider.morse, thickness: $_thickness, color: Colors.deepOrange)''',
          child: Column(
            children: [
              const Text('Dashed Pattern:', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              WxDivider(pattern: WxDivider.dashed, thickness: _thickness, color: Colors.indigo),
              const SizedBox(height: 16),
              const Text('Dotted Pattern:', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              WxDivider(pattern: WxDivider.dotted, thickness: _thickness, color: Colors.teal),
              const SizedBox(height: 16),
              const Text('Morse Code Pattern:', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              WxDivider(pattern: WxDivider.morse, thickness: _thickness, color: Colors.deepOrange),
              const SizedBox(height: 24),
              Row(
                children: [
                  const Text('Thickness:'),
                  Expanded(
                    child: Slider(
                      value: _thickness,
                      min: 1.0,
                      max: 6.0,
                      onChanged: (val) => setState(() => _thickness = val),
                    ),
                  ),
                  Text('${_thickness.toStringAsFixed(1)}px'),
                ],
              ),
            ],
          ),
        ),
        ShowcaseCard(
          title: 'Embedded Badge & Center Child',
          subtitle: 'Embed centered chips, icons, or badges seamlessly into divider gaps.',
          child: Column(
            children: [
              WxDivider(
                color: Colors.grey,
                child: Chip(
                  avatar: const Icon(Icons.star_rounded, size: 16, color: Colors.amber),
                  label: const Text('Featured Section'),
                  backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class WxTileShowcase extends StatelessWidget {
  const WxTileShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return ShowcaseScaffold(
      packageName: 'wx_tile',
      version: '2.0.0',
      description:
          'Composable, styled list tiles and text tiles with flexible leading/trailing widgets, smooth state changes, and theme animation.',
      children: [
        ShowcaseCard(
          title: 'Interactive List Tile Variations',
          subtitle: 'Clean tiles with leading avatars, custom title typography, subtitles, and trailing controls.',
          codeSnippet: '''
WxListTile(
  leading: CircleAvatar(child: Icon(Icons.security)),
  title: Text('Account Security'),
  subtitle: Text('Two-factor authentication enabled'),
  trailing: Icon(Icons.chevron_right),
)''',
          child: Column(
            children: [
              WxListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  child: Icon(Icons.security_rounded, color: Colors.white),
                ),
                title: const Text('Account Security', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text('Two-factor authentication is active'),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () {},
              ),
              const Divider(height: 1),
              WxListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.purpleAccent,
                  child: Icon(Icons.palette_rounded, color: Colors.white),
                ),
                title: const Text('Appearance & Theme', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text('Dynamic color scheme enabled'),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class WxAvatarShowcase extends StatelessWidget {
  const WxAvatarShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return const ShowcaseScaffold(
      packageName: 'wx_avatar',
      version: '3.1.0',
      description:
          'Avatar system supporting initials, fallback icons, image loading, status indicators, and diverse silhouette shapes.',
      children: [
        ShowcaseCard(
          title: 'Avatar Silhouettes & Shapes',
          subtitle: 'Circles, squircles, and stadiums with automatic initials extraction.',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              WxAvatar.circle(
                radius: 28,
                backgroundColor: Colors.indigo,
                child: Text('VT', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              WxAvatar.circle(
                radius: 28,
                backgroundColor: Colors.teal,
                child: Text('JD', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              WxAvatar.circle(
                radius: 28,
                backgroundColor: Colors.deepOrange,
                child: Icon(Icons.person_rounded, color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class WxBadgeShowcase extends StatelessWidget {
  const WxBadgeShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return const ShowcaseScaffold(
      packageName: 'wx_badge',
      version: '3.0.0',
      description:
          'Versatile badge system with numerical counters, overflow capping (+99), status dots, and flexible positioning.',
      children: [
        ShowcaseCard(
          title: 'Badge Variations & Anchoring',
          subtitle: 'Anchor numeric and status dot badges to any arbitrary target widget.',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              WxBadge(
                content: Text('5'),
                position: WxBadgePosition.topRight,
                child: IconButton(
                  icon: Icon(Icons.notifications_rounded, size: 32),
                  onPressed: null,
                ),
              ),
              WxBadge(
                content: Text('99+'),
                position: WxBadgePosition.topRight,
                child: IconButton(
                  icon: Icon(Icons.shopping_cart_rounded, size: 32),
                  onPressed: null,
                ),
              ),
              WxBadge(
                content: Text('•'),
                position: WxBadgePosition.bottomRight,
                child: CircleAvatar(
                  radius: 20,
                  child: Icon(Icons.person_rounded),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class FancyBorderShowcase extends StatelessWidget {
  const FancyBorderShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return ShowcaseScaffold(
      packageName: 'fancy_border',
      version: '0.0.3',
      description:
          'Advanced vector border shapes beyond Flutter defaults, including superellipses (squircles), scalloped corners, and customizable radius curves.',
      children: [
        ShowcaseCard(
          title: 'Squircle & Continuous Corner Borders',
          subtitle: 'Craft Apple-like continuous corner contours with FancyBorder.',
          codeSnippet: '''
ShapeDecoration(
  shape: FancyBorder(
    style: FancyBorderStyle.dashed,
    width: 2,
    color: Colors.deepPurple,
    corners: BorderRadius.all(Radius.circular(16)),
  ),
)''',
          child: Center(
            child: Container(
              width: 180,
              height: 100,
              decoration: const ShapeDecoration(
                shape: FancyBorder(
                  style: FancyBorderStyle.dashed,
                  width: 2,
                  color: Colors.deepPurple,
                  corners: BorderRadius.all(Radius.circular(16)),
                ),
              ),
              alignment: Alignment.center,
              child: const Text('FancyBorder Dashed', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ),
      ],
    );
  }
}

class OverlapStackShowcase extends StatelessWidget {
  const OverlapStackShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return ShowcaseScaffold(
      packageName: 'overlap_stack',
      version: '1.0.1',
      description:
          'Declarative overlapping stacks for avatar facepiles, layered cards, and automatic +N overflow badges.',
      children: [
        ShowcaseCard(
          title: 'Avatar Facepile Stack',
          subtitle: 'Render overlapping user groups with automatic limit capping.',
          codeSnippet: '''
OverlapStack(
  itemLimit: 4,
  itemSize: const Size(40, 40),
  children: [...],
)''',
          child: Center(
            child: OverlapStack(
              itemLimit: 4,
              itemSize: const Size(40, 40),
              children: [
                CircleAvatar(backgroundColor: Colors.red.shade400, child: const Text('A')),
                CircleAvatar(backgroundColor: Colors.blue.shade400, child: const Text('B')),
                CircleAvatar(backgroundColor: Colors.green.shade400, child: const Text('C')),
                CircleAvatar(backgroundColor: Colors.amber.shade400, child: const Text('D')),
                CircleAvatar(backgroundColor: Colors.purple.shade400, child: const Text('E')),
                CircleAvatar(backgroundColor: Colors.teal.shade400, child: const Text('F')),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class WxAnchorShowcase extends StatefulWidget {
  const WxAnchorShowcase({super.key});

  @override
  State<WxAnchorShowcase> createState() => _WxAnchorShowcaseState();
}

class _WxAnchorShowcaseState extends State<WxAnchorShowcase> {
  late final WidgetEventController _eventController;
  int _tapCount = 0;
  bool _disabled = false;

  @override
  void initState() {
    super.initState();
    _eventController = WidgetEventController();
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ShowcaseScaffold(
      packageName: 'wx_anchor',
      version: '2.1.1',
      description:
          'Universal click and touch responsive surface with built-in visual feedback (scale, opacity, overlays), cursor handling, and state orchestration.',
      children: [
        ShowcaseCard(
          title: 'Interactive Anchor Card',
          subtitle: 'Touch-responsive card with smooth scale and overlay feedback.',
          codeSnippet: '''
WxAnchor(
  borderRadius: BorderRadius.circular(16),
  scale: 0.97,
  overlay: true,
  overlayColor: Theme.of(context).colorScheme.primary,
  eventsController: _eventController,
  onTap: () => setState(() => _tapCount++),
  child: ...
)''',
          child: Column(
            children: [
              WxAnchor(
                borderRadius: BorderRadius.circular(16),
                scale: 0.97,
                overlay: true,
                overlayColor: colorScheme.primary,
                eventsController: _eventController,
                disabled: _disabled,
                onTap: () => setState(() => _tapCount++),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: colorScheme.outlineVariant.withValues(alpha: 0.5),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: colorScheme.primaryContainer,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.touch_app_rounded,
                          color: colorScheme.onPrimaryContainer,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tap or Hover This Anchor',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Tapped $_tapCount times • Scale & ripple feedback active',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ListenableBuilder(
                listenable: _eventController,
                builder: (context, _) {
                  final events = _eventController.value;
                  return Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        'Live Events:',
                        style: theme.textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      _EventBadge(
                        label: 'Hovered',
                        active: events.contains(WidgetEvent.hovered),
                        color: Colors.blue,
                      ),
                      _EventBadge(
                        label: 'Pressed',
                        active: events.contains(WidgetEvent.pressed),
                        color: Colors.orange,
                      ),
                      _EventBadge(
                        label: 'Focused',
                        active: events.contains(WidgetEvent.focused),
                        color: Colors.purple,
                      ),
                      _EventBadge(
                        label: 'Disabled',
                        active: events.contains(WidgetEvent.disabled),
                        color: Colors.red,
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilterChip(
                    label: const Text('Toggle Disabled'),
                    selected: _disabled,
                    onSelected: (val) => setState(() => _disabled = val),
                  ),
                  const SizedBox(width: 12),
                  OutlinedButton.icon(
                    onPressed: () => setState(() => _tapCount = 0),
                    icon: const Icon(Icons.refresh_rounded, size: 16),
                    label: const Text('Reset Count'),
                  ),
                ],
              ),
            ],
          ),
        ),
        ShowcaseCard(
          title: 'Circular Anchors & Custom Overlays',
          subtitle: 'Circular action anchors with customized ripple radius and icons.',
          codeSnippet: '''
WxAnchor.circle(
  overlayRadius: 28,
  overlayColor: Colors.deepPurple,
  onTap: () {},
  child: Icon(Icons.favorite_rounded),
)''',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              WxAnchor.circle(
                overlayRadius: 28,
                overlayColor: Colors.pink,
                scale: 0.88,
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Icon(Icons.favorite_rounded, color: Colors.pink.shade400, size: 28),
                ),
              ),
              WxAnchor.circle(
                overlayRadius: 28,
                overlayColor: Colors.amber,
                scale: 0.88,
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Icon(Icons.star_rounded, color: Colors.amber.shade600, size: 28),
                ),
              ),
              WxAnchor.circle(
                overlayRadius: 28,
                overlayColor: Colors.blue,
                scale: 0.88,
                onTap: () {},
                child: const Padding(
                  padding: EdgeInsets.all(12),
                  child: Icon(Icons.share_rounded, color: Colors.blue, size: 28),
                ),
              ),
              WxAnchor.circle(
                overlayRadius: 28,
                overlayColor: Colors.green,
                scale: 0.88,
                onTap: () {},
                child: const Padding(
                  padding: EdgeInsets.all(12),
                  child: Icon(Icons.bookmark_rounded, color: Colors.green, size: 28),
                ),
              ),
            ],
          ),
        ),
        ShowcaseCard(
          title: 'WidgetStatesController Bridge Integration',
          subtitle: 'Seamless two-way bridge connecting WxAnchor events to Flutter native WidgetState.',
          codeSnippet: '''
// Convert WidgetEvents to native Flutter WidgetStates in real-time
final nativeStates = _eventController.value.toWidgetStates();
final isNativePressed = nativeStates.contains(WidgetState.pressed);
''',
          child: ListenableBuilder(
            listenable: _eventController,
            builder: (context, _) {
              final nativeStates = _eventController.value.toWidgetStates();
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.hub_rounded, color: colorScheme.primary),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Mapped Native WidgetStates: ${nativeStates.isEmpty ? "{}" : nativeStates.map((s) => s.name).toSet()}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _EventBadge extends StatelessWidget {
  final String label;
  final bool active;
  final MaterialColor color;

  const _EventBadge({
    required this.label,
    required this.active,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: active ? color.shade100 : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: active ? color.shade700 : Colors.grey.shade400,
          width: active ? 1.5 : 1,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: active ? FontWeight.bold : FontWeight.normal,
          color: active ? color.shade900 : Colors.grey.shade600,
        ),
      ),
    );
  }
}
