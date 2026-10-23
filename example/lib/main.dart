import 'package:flutter/material.dart';
import 'package:widgetarian/widgetarian.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const WidgetarianShowroomApp());
}

Future<void> _openURL(String url) async {
  final Uri uri = Uri.parse(url);
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    debugPrint('Could not launch $uri');
  }
}

class WidgetarianShowroomApp extends StatefulWidget {
  const WidgetarianShowroomApp({super.key});

  @override
  State<WidgetarianShowroomApp> createState() => _WidgetarianShowroomAppState();
}

class _WidgetarianShowroomAppState extends State<WidgetarianShowroomApp> {
  ThemeMode _themeMode = ThemeMode.system;
  Color _seedColor = Colors.deepPurple;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Widgetarian Showroom',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: _seedColor,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: _seedColor,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: ShowroomHomePage(
        themeMode: _themeMode,
        seedColor: _seedColor,
        onThemeModeChanged: (mode) => setState(() => _themeMode = mode),
        onSeedColorChanged: (color) => setState(() => _seedColor = color),
      ),
    );
  }
}

class ShowroomHomePage extends StatefulWidget {
  const ShowroomHomePage({
    super.key,
    required this.themeMode,
    required this.seedColor,
    required this.onThemeModeChanged,
    required this.onSeedColorChanged,
  });

  final ThemeMode themeMode;
  final Color seedColor;
  final ValueChanged<ThemeMode> onThemeModeChanged;
  final ValueChanged<Color> onSeedColorChanged;

  @override
  State<ShowroomHomePage> createState() => _ShowroomHomePageState();
}

class _ShowroomHomePageState extends State<ShowroomHomePage> {
  int _selectedCategoryIndex = 0;

  final List<String> _categories = const [
    'All Components',
    'Typography & Text',
    'Pickers & Choices',
    'UI & Layout',
    'Animations & Feedback',
  ];

  // Demo States
  bool _checkmarkChecked = true;
  double _animatedScale = 1.0;
  String? _selectedCategory = 'Flutter';
  List<String> _selectedTags = ['UI', 'Animation'];
  int _badgeCount = 4;
  int _wheelSelected = 3;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            WxAvatar.circle(
              radius: 16,
              backgroundColor: Colors.deepPurple,
              child: Text('W', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            SizedBox(width: 12),
            Text('Widgetarian Showroom', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Toggle Theme',
            icon: Icon(
              widget.themeMode == ThemeMode.dark
                  ? Icons.dark_mode
                  : widget.themeMode == ThemeMode.light
                      ? Icons.light_mode
                      : Icons.brightness_auto,
            ),
            onPressed: () {
              final next = widget.themeMode == ThemeMode.light
                  ? ThemeMode.dark
                  : widget.themeMode == ThemeMode.dark
                      ? ThemeMode.system
                      : ThemeMode.light;
              widget.onThemeModeChanged(next);
            },
          ),
          IconButton(
            tooltip: 'GitHub Repository',
            icon: const Icon(Icons.code),
            onPressed: () => _openURL('https://github.com/davigmacode/flutter_wx'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1080),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            children: [
              // Hero Banner
              _buildHeroBanner(theme, isDark),
              const SizedBox(height: 24),

              // Category Filter Bar
              _buildCategorySelector(),
              const SizedBox(height: 28),

              // Component Sections
              if (_selectedCategoryIndex == 0 || _selectedCategoryIndex == 1) ...[
                _buildSectionHeader('Typography & Content', 'wx_text, wx_text_animated, wx_spoiler, marquee_transition'),
                _buildTypographySection(theme),
                const SizedBox(height: 32),
              ],

              if (_selectedCategoryIndex == 0 || _selectedCategoryIndex == 2) ...[
                _buildSectionHeader('Pickers & Choices', 'choice, wheel_choice, wheel_choice_ext'),
                _buildPickersSection(theme),
                const SizedBox(height: 32),
              ],

              if (_selectedCategoryIndex == 0 || _selectedCategoryIndex == 3) ...[
                _buildSectionHeader('UI & Structure', 'wx_tile, wx_avatar, wx_badge, wx_box, wx_divider, fancy_border, overlap_stack'),
                _buildUIStructureSection(theme),
                const SizedBox(height: 32),
              ],

              if (_selectedCategoryIndex == 0 || _selectedCategoryIndex == 4) ...[
                _buildSectionHeader('Animations & Controls', 'animated_checkmark, animated_transform, animated_repeatable, disclosure, chronograph'),
                _buildAnimationsSection(theme),
                const SizedBox(height: 48),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroBanner(ThemeData theme, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [Colors.deepPurple.shade900, Colors.indigo.shade900]
              : [Colors.deepPurple.shade50, Colors.indigo.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withAlpha(80),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'UMBRELLA V1.0.0',
                  style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 12),
              const Text('Unified Monorepo Architecture', style: TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 16),
          const WxText.displaySmall(
            'The Widgetarian UI Toolkit',
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 8),
          Text(
            'Explore 26 composable Flutter packages spanning typography, animations, selection sheets, custom pickers, and layout tiles under one ecosystem.',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              _buildMetricChip(Icons.inventory_2_outlined, '26 Packages'),
              _buildMetricChip(Icons.speed, 'Zero-Dep Primitives'),
              _buildMetricChip(Icons.palette_outlined, 'Material 3 Ready'),
              _buildMetricChip(Icons.auto_awesome, 'Dart 3 Workspace'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricChip(IconData icon, String label) {
    return Chip(
      avatar: Icon(icon, size: 16),
      label: Text(label, style: const TextStyle(fontSize: 12)),
      visualDensity: VisualDensity.compact,
    );
  }

  Widget _buildCategorySelector() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List<Widget>.generate(_categories.length, (index) {
          final isSelected = _selectedCategoryIndex == index;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ChoiceChip(
              selected: isSelected,
              label: Text(_categories[index]),
              onSelected: (selected) {
                if (selected) setState(() => _selectedCategoryIndex = index);
              },
            ),
          );
        }),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String packages) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 2),
          Text(
            packages,
            style: TextStyle(
              fontSize: 13,
              fontFamily: 'monospace',
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypographySection(ThemeData theme) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const WxText.titleLarge(
              'Gradient & Outlined Typography',
              gradient: LinearGradient(
                colors: [Colors.purple, Colors.blueAccent],
              ),
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 16),
            const WxText(
              'WxText provides seamless styling, shadows, and text variations.',
              variant: WxTextVariant.bodyMedium,
            ),
            const SizedBox(height: 24),
            const Text('WxSpoiler (Tap to reveal concealed content):', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            WxSpoiler(
              overlay: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.visibility_off, color: Colors.white, size: 16),
                    SizedBox(width: 6),
                    Text('Spoiler (Click to reveal)', style: TextStyle(color: Colors.white, fontSize: 12)),
                  ],
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text('🎉 Exclusive Secret Content successfully revealed by WxSpoiler!'),
              ),
            ),
            const SizedBox(height: 24),
            const Text('MarqueeTransition (Continuous scrolling):', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Container(
              height: 40,
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: const MarqueeTransition(
                duration: Duration(seconds: 8),
                children: [
                  Text('🚀 Widgetarian Monorepo is now live! • Clean code architecture • Full test coverage • '),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPickersSection(ThemeData theme) {
    final categories = ['Flutter', 'Dart', 'React', 'Kotlin', 'Swift', 'Go'];
    final tags = ['UI', 'Animation', 'State', 'Backend'];

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Choice (Inline Single & Multiple Selection):', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            InlineChoice<String>.single(
              value: _selectedCategory,
              onChanged: (val) => setState(() => _selectedCategory = val),
              itemCount: categories.length,
              itemBuilder: (state, i) {
                final item = categories[i];
                return ChoiceChip(
                  label: Text(item),
                  selected: state.selected(item),
                  onSelected: state.onSelected(item),
                );
              },
              listBuilder: ChoiceList.createWrapped(spacing: 8, runSpacing: 8),
            ),
            const SizedBox(height: 16),
            InlineChoice<String>.multiple(
              value: _selectedTags,
              onChanged: (val) => setState(() => _selectedTags = val),
              itemCount: tags.length,
              itemBuilder: (state, i) {
                final tag = tags[i];
                return FilterChip(
                  label: Text(tag),
                  selected: state.selected(tag),
                  onSelected: state.onSelected(tag),
                );
              },
              listBuilder: ChoiceList.createWrapped(spacing: 8, runSpacing: 8),
            ),
            const SizedBox(height: 24),
            const Text('WheelChoice (iOS-Style Picker Wheel):', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            SizedBox(
              height: 120,
              child: WheelChoice<int>(
                value: _wheelSelected,
                options: const [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
                onChanged: (val) => setState(() => _wheelSelected = val),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUIStructureSection(ThemeData theme) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('WxListTile, WxAvatar & WxBadge:', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            WxListTile(
              leading: const WxAvatar.circle(
                backgroundColor: Colors.indigo,
                child: Text('VT', style: TextStyle(color: Colors.white)),
              ),
              title: const Text('Vigma Taufik'),
              subtitle: const Text('Maintainer of Widgetarian'),
              trailing: WxBadge(
                content: Text('$_badgeCount'),
                position: WxBadgePosition.topRight,
                child: IconButton(
                  icon: const Icon(Icons.notifications_outlined),
                  onPressed: () => setState(() => _badgeCount++),
                ),
              ),
            ),
            const WxDivider(
              spacing: 24,
              color: Colors.black12,
            ),
            const Text('FancyBorder (Dashed / Pattern Borders):', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: const ShapeDecoration(
                shape: FancyBorder(
                  style: FancyBorderStyle.dashed,
                  width: 2,
                  color: Colors.deepPurple,
                  corners: BorderRadius.all(Radius.circular(12)),
                ),
              ),
              child: const Center(
                child: Text('Dashed Custom ShapeBorder via FancyBorder'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimationsSection(ThemeData theme) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Checkmark (animated_checkmark):', style: TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () => setState(() => _checkmarkChecked = !_checkmarkChecked),
                        child: Checkmark(
                          checked: _checkmarkChecked,
                          size: 48,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('AnimatedTransform (Tap):', style: TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () => setState(() => _animatedScale = _animatedScale == 1.0 ? 1.25 : 1.0),
                        child: AnimatedTransform(
                          scale: _animatedScale,
                          duration: const Duration(milliseconds: 300),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.secondaryContainer,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text('Scale Me!'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text('Disclosure (Expandable Accordion):', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            const Card.outlined(
              clipBehavior: Clip.antiAlias,
              child: Disclosure(
                header: DisclosureButton(
                  child: ListTile(
                    title: Text('Disclosure Panel Accordion'),
                    trailing: DisclosureIcon(),
                  ),
                ),
                divider: Divider(height: 1),
                child: DisclosureView(
                  padding: EdgeInsets.all(16.0),
                  child: Text('Smooth collapsible content animated with the disclosure package.'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
